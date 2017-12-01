select CONCAT('echo {"segment_id":',min(segName.segment.id)) from segmentsforactivity lateral view explode(segment_efforts) segTable as segName group by segName.name;
