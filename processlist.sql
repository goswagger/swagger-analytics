select CONCAT("./goswagger.sh ",athlete.id, " ", access_token, " |& tee ", athlete.id, ".out") from members
UNION
select CONCAT('curl --data-urlencode "data@analysis01-',athlete.id,'.out" --data-urlencode "tableid=analysis01-',athlete.id,'.out" http://www.goswagger.com/sample-page/?reqtype=updanalysis') from members
UNION
select CONCAT('curl --data-urlencode "data@analysis02-',athlete.id,'.out" --data-urlencode "tableid=analysis02-',athlete.id,'.out" http://www.goswagger.com/sample-page/?reqtype=updanalysis') from members
UNION
select CONCAT('curl --data-urlencode "data@analysis03-',athlete.id,'.out" --data-urlencode "tableid=analysis03-',athlete.id,'.out" http://www.goswagger.com/sample-page/?reqtype=updanalysis') from members
UNION
select CONCAT('curl --data-urlencode "data@swaggerking-',athlete.id,'.out" --data-urlencode "tableid=swaggerking-',athlete.id,'.out" http://www.goswagger.com/sample-page/?reqtype=updanalysis') from members;
