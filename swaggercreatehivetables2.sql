DROP TABLE leaderboardforsegment;
CREATE TABLE leaderboardforsegment (
segment_id int,
effort_count int,
entries array<struct<activity_id:int, athlete_gender:string, athlete_id:int, athlete_name:string, athlete_profile:string, average_hr:double, average_watts:double, distance:double, effort_id:bigint, elapsed_time:int, moving_time:int, neighborhood_index:int, rank:int, start_date:string, start_date_local:string>>,
entry_count int,
kom_type string,
neighborhood_count int)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
STORED AS TEXTFILE;

/* We keep this table around, so comment out so it's not dropped 
CREATE TABLE members (
access_token string,
token_type string,
athlete struct<id:int, username:string, resource_state:int, firstname:string, lastname:string, city:string, state:string, country:string, sex:string, premium:boolean, created_at:timestamp, updated_at:timestamp, badge_type_id:int, profile_medium:string, profile:string, friend:string, follower:string, email:string>
)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe';
*/
