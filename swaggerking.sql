select athlete_id, max(athlete_name) as athlete, 
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
from (
select b.entries[0].athlete_id AS athlete_id, b.entries[0].athlete_name as athlete_name, b.entries[0].rank as rank, b.segment_id as segment_id
from leaderboardforsegment b
union
select b.entries[1].athlete_id as athlete_id, b.entries[1].athlete_name as athlete_name, b.entries[1].rank as rank, b.segment_id as segment_id
from leaderboardforsegment b
union
select b.entries[2].athlete_id as athlete_id, b.entries[2].athlete_name as athlete_name, b.entries[2].rank as rank, b.segment_id as segment_id
from leaderboardforsegment b
union
select b.entries[3].athlete_id as athlete_id, b.entries[3].athlete_name as athlete_name, b.entries[3].rank as rank, b.segment_id as segment_id
from leaderboardforsegment b
union
select b.entries[4].athlete_id as athlete_id, b.entries[4].athlete_name as athlete_name, b.entries[4].rank as rank, b.segment_id as segment_id
from leaderboardforsegment b
union
select b.entries[5].athlete_id as athlete_id, b.entries[5].athlete_name as athlete_name, b.entries[5].rank as rank, b.segment_id as segment_id
from leaderboardforsegment b
union
select b.entries[6].athlete_id as athlete_id, b.entries[6].athlete_name as athlete_name, b.entries[6].rank as rank, b.segment_id as segment_id
from leaderboardforsegment b
union
select b.entries[7].athlete_id as athlete_id, b.entries[7].athlete_name as athlete_name, b.entries[7].rank as rank, b.segment_id as segment_id
from leaderboardforsegment b
union
select b.entries[8].athlete_id as athlete_id, b.entries[8].athlete_name as athlete_name, b.entries[8].rank as rank, b.segment_id as segment_id
from leaderboardforsegment b
union
select b.entries[9].athlete_id as athlete_id, b.entries[9].athlete_name as athlete_name, b.entries[9].rank as rank, b.segment_id as segment_id
from leaderboardforsegment b
union
select b.entries[10].athlete_id as athlete_id, b.entries[10].athlete_name as athlete_name, b.entries[10].rank as rank, b.segment_id as segment_id
from leaderboardforsegment b
) as t2
group by athlete_id, athlete_name
having points > 0
order by points desc;