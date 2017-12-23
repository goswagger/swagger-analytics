insert overwrite table swaggerkingsegments select segment_id, entries[0].athlete_id,regexp_replace(entries[0].athlete_name, '[^\\x20-\\x7A]+', ''), entries[0].rank from leaderboardforsegment where segment_id in (select segment_id from besteffortforsegments);
insert into table swaggerkingsegments select segment_id, entries[1].athlete_id,regexp_replace(entries[1].athlete_name, '[^\\x20-\\x7A]+', ''), entries[1].rank from leaderboardforsegment where segment_id in (select segment_id from besteffortforsegments);
insert into table swaggerkingsegments select segment_id, entries[2].athlete_id,regexp_replace(entries[2].athlete_name, '[^\\x20-\\x7A]+', ''), entries[2].rank from leaderboardforsegment where segment_id in (select segment_id from besteffortforsegments);
insert into table swaggerkingsegments select segment_id, entries[3].athlete_id,regexp_replace(entries[3].athlete_name, '[^\\x20-\\x7A]+', ''), entries[3].rank from leaderboardforsegment where segment_id in (select segment_id from besteffortforsegments);
insert into table swaggerkingsegments select segment_id, entries[4].athlete_id,regexp_replace(entries[4].athlete_name, '[^\\x20-\\x7A]+', ''), entries[4].rank from leaderboardforsegment where segment_id in (select segment_id from besteffortforsegments);
insert into table swaggerkingsegments select segment_id, entries[5].athlete_id,regexp_replace(entries[5].athlete_name, '[^\\x20-\\x7A]+', ''), entries[5].rank from leaderboardforsegment where segment_id in (select segment_id from besteffortforsegments);
insert into table swaggerkingsegments select segment_id, entries[6].athlete_id,regexp_replace(entries[6].athlete_name, '[^\\x20-\\x7A]+', ''), entries[6].rank from leaderboardforsegment where segment_id in (select segment_id from besteffortforsegments);
insert into table swaggerkingsegments select segment_id, entries[7].athlete_id,regexp_replace(entries[7].athlete_name, '[^\\x20-\\x7A]+', ''), entries[7].rank from leaderboardforsegment where segment_id in (select segment_id from besteffortforsegments);
insert into table swaggerkingsegments select segment_id, entries[8].athlete_id,regexp_replace(entries[8].athlete_name, '[^\\x20-\\x7A]+', ''), entries[8].rank from leaderboardforsegment where segment_id in (select segment_id from besteffortforsegments);
insert into table swaggerkingsegments select segment_id, entries[9].athlete_id,regexp_replace(entries[9].athlete_name, '[^\\x20-\\x7A]+', ''), entries[9].rank from leaderboardforsegment where segment_id in (select segment_id from besteffortforsegments);

select row_number() over (order by points desc) ranking, CONCAT("<a href='https://www.strava.com/athletes/",athlete_id,"/' rel='noopener noreferrer' target='_blank'>",max(athlete_name),"</a>") as athlete, 
sum(case rank
when 1 then 25
when 2 then 18
when 3 then 15
when 4 then 12
when 5 then 10
when 6 then 8
when 7 then 6
when 8 then 4
when 9 then 2
when 10 then 1
else 0
end) as points
from (select segment_id, athlete_id, athlete_name, rank from swaggerkingsegments) as T2
group by athlete_id
having points > 0;
