SELECT segment, ranking FROM (
select CONCAT('<a href="https://www.strava.com/segments/',segid,'/" rel="noopener noreferrer" target="_blank">https://www.strava.com/segments/',segid,'</a>') as segment, ranking, segrank from (select b.segment_id as segid, 'kom' as ranking,  if(b.entries[0].athlete_id=ATHLETEID and b.entries[0].rank=1, 1, if(b.entries[1].athlete_id=ATHLETEID and b.entries[1].rank=1, 1, if(b.entries[2].athlete_id=ATHLETEID and b.entries[2].rank=1, 1, if(b.entries[3].athlete_id=ATHLETEID and b.entries[3].rank=1, 1, if(b.entries[4].athlete_id=ATHLETEID and b.entries[4].rank=1, 1, if(b.entries[5].athlete_id=ATHLETEID and b.entries[5].rank=1, 1, if(b.entries[6].athlete_id=ATHLETEID and b.entries[6].rank=1, 1, if(b.entries[7].athlete_id=ATHLETEID and b.entries[7].rank=1, 1, if(b.entries[8].athlete_id=ATHLETEID and b.entries[8].rank=1, 1, if(b.entries[9].athlete_id=ATHLETEID and b.entries[9].rank=1, 1, 0)))))))))) as segrank from leaderboardforsegment b) t2 WHERE segrank > 0
UNION
select CONCAT('<a href="https://www.strava.com/segments/',segid,'/" rel="noopener noreferrer" target="_blank">https://www.strava.com/segments/',segid,'</a>')  as segment, ranking, segrank from (select b.segment_id as segid, ' 2nd' as ranking, if(b.entries[1].athlete_id=ATHLETEID and b.entries[1].rank=2, 1, if(b.entries[2].athlete_id=ATHLETEID and b.entries[2].rank=2, 1, if(b.entries[3].athlete_id=ATHLETEID and b.entries[3].rank=2, 1, if(b.entries[4].athlete_id=ATHLETEID and b.entries[4].rank=2, 1, if(b.entries[5].athlete_id=ATHLETEID and b.entries[5].rank=2, 1, if(b.entries[6].athlete_id=ATHLETEID and b.entries[6].rank=2, 1, if(b.entries[7].athlete_id=ATHLETEID and b.entries[7].rank=2, 1, if(b.entries[8].athlete_id=ATHLETEID and b.entries[8].rank=2, 1, if(b.entries[9].athlete_id=ATHLETEID and b.entries[9].rank=2, 1, 0))))))))) as segrank from leaderboardforsegment b) t2 WHERE segrank > 0
UNION
select CONCAT('<a href="https://www.strava.com/segments/',segid,'/" rel="noopener noreferrer" target="_blank">https://www.strava.com/segments/',segid,'</a>') as segment, ranking, segrank from (select b.segment_id as segid, ' 3rd' as ranking, if(b.entries[2].athlete_id=ATHLETEID and b.entries[2].rank=3, 1, if(b.entries[3].athlete_id=ATHLETEID and b.entries[3].rank=3, 1, if(b.entries[4].athlete_id=ATHLETEID and b.entries[4].rank=3, 1, if(b.entries[5].athlete_id=ATHLETEID and b.entries[5].rank=3, 1, if(b.entries[6].athlete_id=ATHLETEID and b.entries[6].rank=3, 1, if(b.entries[7].athlete_id=ATHLETEID and b.entries[7].rank=3, 1, if(b.entries[8].athlete_id=ATHLETEID and b.entries[8].rank=3, 1, if(b.entries[9].athlete_id=ATHLETEID and b.entries[9].rank=3, 1, 0)))))))) as segrank from leaderboardforsegment b) t2 WHERE segrank > 0
UNION
select CONCAT('<a href="https://www.strava.com/segments/',segid,'/" rel="noopener noreferrer" target="_blank">https://www.strava.com/segments/',segid,'</a>') as segment, ranking, segrank from (select b.segment_id as segid, ' 4th' as ranking, if(b.entries[3].athlete_id=ATHLETEID and b.entries[3].rank=4, 1, if(b.entries[4].athlete_id=ATHLETEID and b.entries[4].rank=4, 1, if(b.entries[5].athlete_id=ATHLETEID and b.entries[5].rank=4, 1, if(b.entries[6].athlete_id=ATHLETEID and b.entries[6].rank=4, 1, if(b.entries[7].athlete_id=ATHLETEID and b.entries[7].rank=4, 1, if(b.entries[8].athlete_id=ATHLETEID and b.entries[8].rank=4, 1, if(b.entries[9].athlete_id=ATHLETEID and b.entries[9].rank=4, 1, 0))))))) as segrank from leaderboardforsegment b) t2 WHERE segrank > 0
UNION
select CONCAT('<a href="https://www.strava.com/segments/',segid,'/" rel="noopener noreferrer" target="_blank">https://www.strava.com/segments/',segid,'</a>') as segment, ranking, segrank from (select b.segment_id as segid, ' 5th' as ranking, if(b.entries[4].athlete_id=ATHLETEID and b.entries[4].rank=5, 1, if(b.entries[5].athlete_id=ATHLETEID and b.entries[5].rank=5, 1, if(b.entries[6].athlete_id=ATHLETEID and b.entries[6].rank=5, 1, if(b.entries[7].athlete_id=ATHLETEID and b.entries[7].rank=5, 1, if(b.entries[8].athlete_id=ATHLETEID and b.entries[8].rank=5, 1, if(b.entries[9].athlete_id=ATHLETEID and b.entries[9].rank=5, 1, 0)))))) as segrank from leaderboardforsegment b) t2 WHERE segrank > 0
UNION
select CONCAT('<a href="https://www.strava.com/segments/',segid,'/" rel="noopener noreferrer" target="_blank">https://www.strava.com/segments/',segid,'</a>') as segment, ranking, segrank from (select b.segment_id as segid, ' 6th' as ranking, if(b.entries[5].athlete_id=ATHLETEID and b.entries[5].rank=6, 1, if(b.entries[6].athlete_id=ATHLETEID and b.entries[6].rank=6, 1, if(b.entries[7].athlete_id=ATHLETEID and b.entries[7].rank=6, 1, if(b.entries[8].athlete_id=ATHLETEID and b.entries[8].rank=6, 1, if(b.entries[9].athlete_id=ATHLETEID and b.entries[9].rank=6, 1, 0))))) as segrank from leaderboardforsegment b) t2 WHERE segrank > 0
UNION
select CONCAT('<a href="https://www.strava.com/segments/',segid,'/" rel="noopener noreferrer" target="_blank">https://www.strava.com/segments/',segid,'</a>') as segment, ranking, segrank from (select b.segment_id as segid, ' 7th' as ranking, if(b.entries[6].athlete_id=ATHLETEID and b.entries[6].rank=7, 1, if(b.entries[7].athlete_id=ATHLETEID and b.entries[7].rank=7, 1, if(b.entries[8].athlete_id=ATHLETEID and b.entries[8].rank=7, 1, if(b.entries[9].athlete_id=ATHLETEID and b.entries[9].rank=7, 1, 0)))) as segrank from leaderboardforsegment b) t2 WHERE segrank > 0
UNION
select CONCAT('<a href="https://www.strava.com/segments/',segid,'/" rel="noopener noreferrer" target="_blank">https://www.strava.com/segments/',segid,'</a>') as segment, ranking, segrank from (select b.segment_id as segid, ' 8th' as ranking, if(b.entries[7].athlete_id=ATHLETEID and b.entries[7].rank=8, 1, if(b.entries[8].athlete_id=ATHLETEID and b.entries[8].rank=8, 1, if(b.entries[9].athlete_id=ATHLETEID and b.entries[9].rank=8, 1, 0))) as segrank from leaderboardforsegment b) t2 WHERE segrank > 0
UNION
select CONCAT('<a href="https://www.strava.com/segments/',segid,'/" rel="noopener noreferrer" target="_blank">https://www.strava.com/segments/',segid,'</a>') as segment, ranking, segrank from (select b.segment_id as segid, ' 9th' as ranking, if(b.entries[8].athlete_id=ATHLETEID and b.entries[8].rank=9, 1, if(b.entries[9].athlete_id=ATHLETEID and b.entries[9].rank=9, 1, 0)) as segrank from leaderboardforsegment b) t2 WHERE segrank > 0
UNION
select CONCAT('<a href="https://www.strava.com/segments/',segid,'/" rel="noopener noreferrer" target="_blank">https://www.strava.com/segments/',segid,'</a>') as segment, ranking, segrank from (select b.segment_id as segid, '10th' as ranking, if(b.entries[9].athlete_id=ATHLETEID and b.entries[9].rank=10, 1, 0) as segrank from leaderboardforsegment b) t2 WHERE segrank > 0
) AS T2 ORDER BY ranking;
