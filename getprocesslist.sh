# THIS FILE is the entry point to back-end swagger data processing
#
# 1. Must be hive user before everything else
#	a. su hive -
# 	b. cd ~
#
# 2. Make sure hive members table contains all athletes. Any new people need to be added using:
# 	a. http://www.goswagger.com/todo?reqtype=0  << must be logged into WordPress as todo is private
#	b. copy/paste any new member JSON to a file to add (load) to members hive table (see next step)
#	c. hive -e "load data local inpath '/home/hive/loadmembers.json' into table members;"
#
# 3. Drop and re-create hive table for leaderboard (done once per processing cycle)
beeline -u jdbc:hive2://hiveserver:10000/default -n hive -p hive -f swaggercreatehivetables2.sql
#
# 4. Create list of commands to execute for each athlete in members table
beeline -u jdbc:hive2://hiveserver:10000/default --showHeader=false --slient=true --outputformat=tsv2 -n hive -p hive -f processlist.sql > processlist.sh
# 
# 5. Remove beeline garbage
sed -i '1,7d;$ d' processlist.sh
#
# 6. Make executable
chmod 777 processlist.sh
#
# 7. VERIFY/COMMENT OUT members to run, then execute with ./processlist.sh
