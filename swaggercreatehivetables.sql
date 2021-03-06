DROP TABLE activitiesforathlete;
CREATE TABLE activitiesforathlete (
achievement_count int,
athlete struct<id:int, resource_state:int>,
athlete_count int,
average_heartrate double,
average_speed double,
average_temp double,
average_watts double,
comment_count int,
commute boolean,
device_watts boolean,
distance double,
elapsed_time int,
elev_high double,
elev_low double,
end_latlng array<double>,
external_id string,
flagged boolean,
from_accepted_tag boolean,
gear_id string,
has_heartrate boolean,
has_kudoed boolean,
id int,
kilojoules double,
kudos_count int,
location_city string,
location_country string,
location_state string,
manual boolean,
mapstrava struct<id:string, resource_state:int, summary_polyline:string>,
max_heartrate double,
max_speed double,
moving_time int,
name string,
photo_count int,
pr_count int,
private boolean,
resource_state int,
start_date string,
start_date_local string,
start_latitude double,
start_latlng array<double>,
start_longitude double,
suffer_score int,
timezone string,
total_elevation_gain double,
total_photo_count int,
trainer boolean,
type string,
upload_id int,
utc_offset double,
workout_type int)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
WITH SERDEPROPERTIES ( "mapping.mapstrava" = "map" )
STORED AS TEXTFILE;

DROP TABLE segmentsforactivity;
CREATE TABLE segmentsforactivity (
achievement_count int,
athlete struct<id:int, resource_state:int>,
athlete_count int,
average_cadence double,
average_heartrate double,
average_speed double,
average_temp double,
average_watts double,
calories double,
comment_count int,
commute boolean,
description string,
device_name string,
device_watts boolean,
distance double,
elapsed_time int,
elev_high double,
elev_low double,
embed_token string,
end_latlng array<double>,
external_id string,
flagged boolean,
from_accepted_tag boolean,
gear struct<distance:double, id:string, name:string, primary:boolean, resource_state:int>,
gear_id string,
has_heartrate boolean,
has_kudoed boolean,
highlighted_kudosers array<struct<avatar_url:string, destination_url:string, display_name:string, show_name:boolean>>,
id int,
kilojoules double,
kudos_count int,
laps array<struct<activity:struct<id:int, resource_state:int>, athlete:struct<id:int, resource_state:int>, average_cadence:double, average_heartrate:double, average_speed:double, average_watts:double, device_watts:boolean, distance:double, elapsed_time:int, end_index:int, id:int, lap_index:int, max_heartrate:double, max_speed:double, moving_time:int, name:string, resource_state:int, split:int, start_date:string, start_date_local:string, start_index:int, total_elevation_gain:double>>,
location_city string,
location_country string,
location_state string,
manual boolean,
mapstrava struct<id:string, polyline:string, resource_state:int, summary_polyline:string>,
max_heartrate double,
max_speed double,
max_watts int,
moving_time int,
name string,
partner_brand_tag string,
photo_count int,
photos struct<count:int, primary:boolean>,
pr_count int,
private boolean,
resource_state int,
segment_efforts array<struct<achievements:array<struct<rank:int, type:string, type_id:int>>, activity:struct<id:int, resource_state:int>, athlete:struct<id:int, resource_state:int>, average_cadence:double, average_heartrate:double, average_watts:double, device_watts:boolean, distance:double, elapsed_time:int, end_index:int, hidden:boolean, id:bigint, kom_rank:int, max_heartrate:double, moving_time:int, name:string, pr_rank:int, resource_state:int, segment:struct<activity_type:string, average_grade:double, city:string, climb_category:int, country:string, distance:double, elevation_high:double, elevation_low:double, end_latitude:double, end_latlng:array<double>, end_longitude:double, hazardous:boolean, id:int, maximum_grade:double, name:string, private:boolean, resource_state:int, starred:boolean, start_latitude:double, start_latlng:array<double>, start_longitude:double, state:string>, start_date:string, start_date_local:string, start_index:int>>,
segment_leaderboard_opt_out boolean,
splits_metric array<struct<average_heartrate:double, average_speed:double, distance:double, elapsed_time:int, elevation_difference:double, moving_time:int, pace_zone:int, split:int>>,
splits_standard array<struct<average_heartrate:double, average_speed:double, distance:double, elapsed_time:int, elevation_difference:double, moving_time:int, pace_zone:int, split:int>>,
start_date string,
start_date_local string,
start_latitude double,
start_latlng array<double>,
start_longitude double,
suffer_score int,
timezone string,
total_elevation_gain double,
total_photo_count int,
trainer boolean,
type string,
upload_id int,
utc_offset double,
weighted_average_watts int,
workout_type string)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
WITH SERDEPROPERTIES ( "mapping.mapstrava" = "map" )
STORED AS TEXTFILE;

DROP TABLE besteffortforsegments;
CREATE TABLE besteffortforsegments (
segment_name string,
segment_id int,
elapsed_time int)
STORED AS TEXTFILE;

DROP TABLE swaggerkingsegments;
CREATE TABLE swaggerkingsegments (
segment_id int,
athlete_id int,
athlete_name string,
rank int)
STORED AS TEXTFILE;

DROP TABLE swaggercupcount;
CREATE TABLE swaggercupcount (
segment_id int,
segment_name string,
ranking string,
segrank int)
STORED AS TEXTFILE;
