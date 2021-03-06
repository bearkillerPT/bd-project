DROP PROCEDURE insert_demn;
GO
CREATE PROCEDURE insert_demn
  @emitter_id BIGINT,
  @timestamp INT,
  @cause_code INT,
  @sub_cause_code INT,
  @latitude BIGINT,
  @longitude BIGINT,
  @duration INT,
  @quadtree BIGINT
AS
insert into it2s_db.DENM
values(@emitter_id, @timestamp, @cause_code, @sub_cause_code, @latitude, @longitude, @duration, @quadtree);
GO
