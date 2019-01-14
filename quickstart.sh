JAVA_OPTS="$JAVA_OPTS -Dspring.datasource.url=jdbc:mysql://localhost:3306/lfloginext"
JAVA_OPTS="$JAVA_OPTS -Dspring.datasource.username=lfloginextuser"
JAVA_OPTS="$JAVA_OPTS -Dspring.datasource.password=loginext@1234"

PROJ_CHECKOUT_LOC="/home/ubuntu/lf_logistics/project"
cd "$PROJ_CHECKOUT_LOC"

pwd

echo running gis2mw
nohup java -Dgis2mwSrvc=true $JAVA_OPTS -Dserver.port=8080 -jar mw-rest/gis2mw/target/gis2mw-0.0.1-SNAPSHOT.jar > /dev/null 2>&1 &


echo running scheduler build
nohup java -DschedulercSrvc=true $JAVA_OPTS -jar mw-scheduler/target/mw-scheduler-0.0.1-SNAPSHOT.jar > /dev/null 2>&1 &

echo running loginextwebhook
nohup java -DloginextwebhookSrvc=true $JAVA_OPTS -Dserver.port=8084 -jar mw-rest/loginext2mw/target/loginext2mw-0.0.1-SNAPSHOT.jar > /dev/null 2>&1 &


echo "Following are running"
ps -ef| grep -i  'java -Dgis2mwSrvc=true'|grep -v grep| grep -v root 
ps -ef| grep -i  'java -DschedulercSrvc=true'|grep -v grep| grep -v root 
ps -ef| grep -i  'java -DloginextwebhookSrvc=true'|grep -v grep| grep -v root