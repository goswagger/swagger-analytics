beeline -u jdbc:hive2://hiveserver:10000/default --showHeader=false --slient=true --outputformat=dsv -n hive -p hive -f processlist.sql > processlist.sh
sed -i '1,1d;$ d' processlist.sh
chmod 777 processlist.sh