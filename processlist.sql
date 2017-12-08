select CONCAT("./goswagger.sh ",athlete.id, " ", access_token, " |& tee ", athlete.id, ".out") from members;
