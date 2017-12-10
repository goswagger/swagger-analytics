# drop and re-create hive tables
beeline -u jdbc:hive2://hiveserver:10000/default -n hive -p hive -f swaggercreatehivetables2.sql
# create list of commands to execute for each athlete in members table
beeline -u jdbc:hive2://hiveserver:10000/default --showHeader=false --slient=true --outputformat=tsv2 -n hive -p hive -f processlist.sql > processlist.sh
sed -i '1,7d;$ d' processlist.sh
chmod 777 processlist.sh
