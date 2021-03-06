DROP PROCEDURE insert_website;
GO
CREATE PROCEDURE insert_website
    @emitter_id BIGINT,
    @app_version INT,
    @lang CHAR(2),
    @browser_version INT
AS
BEGIN TRAN
update it2s_db.Emitter set current_app_version=@app_version where  station_id = @emitter_id
IF @@ROWCOUNT=0
    insert into it2s_db.Emitter
values(@emitter_id, @app_version)
update it2s_db.App set configured_language=@lang where  emitter_station_id = @emitter_id
IF @@ROWCOUNT=0
    insert into it2s_db.App
values(@emitter_id, @lang);
update it2s_db.Website set browser_version=@browser_version where  emitter_station_id = @emitter_id
IF @@ROWCOUNT=0
    BEGIN
    IF EXISTS(SELECT *
    FROM it2s_db.Smartphone
    where emitter_station_id = @emitter_id)
        BEGIN
            RAISERROR('Já existe um Smartphone com esse emitter_id!',16,1);
            ROLLBACK TRAN
        END
    ELSE
        BEGIN
            insert into it2s_db.WebSite
            values(@emitter_id, @browser_version);
            COMMIT TRAN
        END
END
GO
