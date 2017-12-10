#!/bin/bash

# su hive - and also cd ~ before executing script
# files needed to run
# analysis1,2,3.sql's, leaderboard1.sql, leaderboard2sql.proto, ratelimiter.sh, goswagger.sh, swaggercreatehivetables.sql

# Environment needed: Hadoop backend (Hortonworks, Cloudera, Apache), JSON jars for Hive/Beeline
# https://github.com/quux00/hive-json-schema
# https://github.com/rcongiu/Hive-JSON-Serde
# http://www.congiu.net/hive-json-serde/1.3.8/

# How to add the Jars for JSON support. ADD JAR is done at Hive command prompt for interactive use.
#     See your Hadoop setup for how to add auxlibs to make persistent but we don't need it.
# ADD JAR /usr/hdp/current/hive-metastore/lib/json-serde-1.3.8-jar-with-dependencies.jar;
# Beeline support (we use this so must do it for code to work)
# put jars in hiveserver node only, after creating the auxlib directory. Then restart hive. Example steps below.
# [root@hiveserver auxlib]# pwd
# /usr/hdp/2.3.0.0-2557/hive/auxlib
# [root@hiveserver auxlib]# ls -l
# -rwxr-xr-x 1 root root 85492 Nov  9 17:08 json-serde-1.3.8-jar-with-dependencies.jar
# -rwxr-xr-x 1 root root  2275 Nov  9 17:09 json-udf-1.3.8-jar-with-dependencies.jar

ARGS=2
E_BADARGS=85
E_NOFILE=86
SUCCESS=0
if [ $# -ne ""$ARGS"" ]  # Correct number of arguments passed to script?
then
echo ""Usage: `basename $0` athleteid access_token |& tee athleteid.out""
echo "example ./goswagger.sh yourAthleteID yourStravaAccessToken |& tee yourAthleteId.out"
exit $E_BADARGS
fi
ATHLETEID=$1
ACCESS_TOKEN=$2

rm -f segmentsforactivity.json
rm -f segmentsforactivity.sh
rm -f leaderboardforsegment.json
rm -f leaderboardforsegment.sh
rm -f leaderboardforsegment1.sh
rm -f leaderboardforsegment2.sh
rm -f leaderboardforsegment1.json
rm -f leaderboardforsegment2.json
rm -f leaderboardforsegment3.json
rm -f analysis1.out
rm -f analysis2.out
rm -f analysis3.out
rm -f analysis2tmp.sql
rm -f analysis3tmp.sql

# drop and re-create hive tables
beeline -u jdbc:hive2://hiveserver:10000/default -n hive -p hive -f swaggercreatehivetables.sql
echo "STEP: swaggercreatehivetables.sql complete ******************************************"

# retrieve strava activities for an athlete (up to 200 of the most recent activities)
curl -D hdr.out -X GET https://www.strava.com/api/v3/athletes/$ATHLETEID/activities -d per_page=200 -d include_all_efforts=true -d access_token=$ACCESS_TOKEN > activitiesforathlete.json
# remove outer array characters [] and insert newline between json rows
sed -i 's/\[{/{/g;s/}\]/}/g' activitiesforathlete.json
sed -i 's/'},{'/}\'$'\n{/g' activitiesforathlete.json
hive -e "load data local inpath '/home/hive/activitiesforathlete.json' overwrite into table activitiesforathlete;"
echo "STEP: retrieve and load activities complete ******************************************"

hive -e "select CONCAT('curl -D hdr.out -X GET https://www.strava.com/api/v3/activities/',id,' -d access_token=$ACCESS_TOKEN') from activitiesforathlete;" > segmentsforactivity.sh
# Partition the curl calls generated in segmentsforactivity.json to fit within the Strava rate limited 600 API calls per 15 minutes
#if [! ./ratelimiter.sh segmentsforactivity -eq 0 ] then exit fi
./ratelimiter.sh segmentsforactivity
hive -e "load data local inpath '/home/hive/segmentsforactivity.json' overwrite into table segmentsforactivity;"
echo "STEP: retrieve and load segments for activity complete ******************************************"

beeline -u jdbc:hive2://hiveserver:10000/default -n hive -p hive -e "insert into table besteffortforsegments select segName.name as segment_name, segName.segment.id as segment_id, min(segName.elapsed_time) as elapsed_time from segmentsforactivity lateral view explode(segment_efforts) segTable as segName group by segName.name, segName.segment.id;"
echo "STEP: create besteffortsforsegments complete ******************************************"

beeline -u jdbc:hive2://hiveserver:10000/default --showHeader=false --slient=true --outputformat=dsv -n hive -p hive -f leaderboard1.sql > leaderboardforsegment1.sh
sed "s/ACCESS_TOKEN/$ACCESS_TOKEN/g" leaderboard2sql.proto > leaderboard2.sql
beeline -u jdbc:hive2://hiveserver:10000/default --showHeader=false --slient=true --outputformat=dsv -n hive -p hive -f leaderboard2.sql > leaderboardforsegment2.sh

# !!!!!! check your beeline for the bug !!!! delete top and bottom rows from both leaderboard1 and leaderboard2.sh files because beeline adds junk (there is a patch in 2015 that fixes this)
sed -i '1,1d;$ d' leaderboardforsegment1.sh
sed -i '1,1d;$ d' leaderboardforsegment2.sh

# Partition the curl calls generated in leaderboardforsegment.json to fit within the Strava rate limited 600 API calls per 15 minutes
#if [! ./ratelimiter.sh leaderboardforsegment2 -eq 0 ] then exit fi
./ratelimiter.sh leaderboardforsegment1
./ratelimiter.sh leaderboardforsegment2

# merge files line by line
paste -d" " leaderboardforsegment1.json leaderboardforsegment2.json > leaderboardforsegment3.json

# sed -i '' '$!N;s/\n/ /' leaderboardforsegment.json
# the following -i should allow in-place edit of file but causes shell to barf (OSX worked)
# sed -i '' 's/ {"effort_count/,"effort_count/g' leaderboardforsegment.json
sed 's/ {"effort_count/,"effort_count/g' leaderboardforsegment3.json > leaderboardforsegment.json

# remove error rows for segment leaderboards not returned due to being "flagged as dangerous"
sed -i '/errors":/d' ./leaderboardforsegment.json
hive -e "load data local inpath '/home/hive/leaderboardforsegment.json' into table leaderboardforsegment;"
echo "STEP: retrieve and load leaderboardforsegment complete ******************************************"

# analysis
beeline -u jdbc:hive2://hiveserver:10000/default --slient=true --outputformat=dsv -n hive -p hive -f analysis1.sql > analysis1.out
# athletes insert " and \ characters in their names, which breaks tablepress (they curl transer fine). replace them with *.
{ sed '1,1d;$ d;s/"/*/g;s/\\/*/g' analysis1.out; } > analysis1a.out
sed 's/|/","/g;s/^/["/;s/$/"]/' analysis1a.out | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/,/g' | sed 's/^/[/;s/$/]/' > analysis01-$ATHLETEID.out
sed "s/ATHLETEID/$ATHLETEID/g" analysis2.sql > analysis2tmp.sql
beeline -u jdbc:hive2://hiveserver:10000/default --slient=true --outputformat=dsv -n hive -p hive -f analysis2tmp.sql > analysis2.out
{ sed '1,12d;$ d' analysis2.out; } > analysis2a.out
sed 's/|/","/g;s/^/["/;s/$/"]/' analysis2a.out | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/,/g' | sed 's/^/[/;s/$/]/' > analysis02-$ATHLETEID.out
sed "s/ATHLETEID/$ATHLETEID/g" analysis3.sql > analysis3tmp.sql
beeline -u jdbc:hive2://hiveserver:10000/default --slient=true --outputformat=dsv -n hive -p hive -f analysis3tmp.sql > analysis3.out
{ sed '1,21d;$ d' analysis3.out; } > analysis3a.out
sed 's/|/","/g;s/^/["/;s/$/"]/' analysis3a.out | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/,/g' | sed 's/^/[/;s/$/]/' > analysis03-$ATHLETEID.out
echo "STEP: analysis complete ******************************************"

# END-OF-FILE
