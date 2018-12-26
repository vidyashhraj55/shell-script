JAVA_OPTS="$JAVA_OPTS -Dspring.datasource.url=jdbc:mysql://localhost:3306/lfloginext"
JAVA_OPTS="$JAVA_OPTS -Dspring.datasource.username=lfloginextuser"
JAVA_OPTS="$JAVA_OPTS -Dspring.datasource.password=loginext@1234"

PROJ_CHECKOUT_LOC="/home/vidya/Documents/loginext"

echo removing the $PROJ_CHECKOUT_LOC
rm -rf "$PROJ_CHECKOUT_LOC"
echo creating the $PROJ_CHECKOUT_LOC
mkdir "$PROJ_CHECKOUT_LOC"



echo cloning started 



git clone -b "$1" https://ushasvu:"$2"@bitbucket.org/ushasvu/loginext-mw.git "$PROJ_CHECKOUT_LOC"

echo cloning ended

cd "$PROJ_CHECKOUT_LOC"

mkdir logs

mvn clean package

echo starting DB build
nohup java -DdbutilSrvc=true $JAVA_OPTS -Dserver.port=8083 -jar mw-rest/mw-db/target/mw-db-0.0.1-SNAPSHOT.jar mw-rest/mw-db/request.xml mw-rest/mw-db/ > logs/dbrun.log 2>&1 &

echo "waiting for DB to create the tables"
sleep 120

echo running gis2mw
nohup java -Dgis2mwSrvc=true $JAVA_OPTS -Dserver.port=8081 -jar mw-rest/gis2mw/target/gis2mw-0.0.1-SNAPSHOT.jar > logs/gis2mwrun.log 2>&1 &


echo running scheduler build
nohup java -DschedulercSrvc=true $JAVA_OPTS -Dserver.port=8082 -jar mw-scheduler/target/mw-scheduler-0.0.1-SNAPSHOT.jar > logs/schedulerrun.log 2>&1 &



