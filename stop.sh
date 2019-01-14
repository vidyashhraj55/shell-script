



ps -ef| grep -i  'java -Dgis2mwSrvc=true'|grep -v grep| grep -v root 
ps -ef| grep -i  'java -Dgis2mwSrvc=true'|grep -v grep| grep -v root | awk '{print $2}' | xargs -r kill -9



ps -ef| grep -i  'java -DschedulercSrvc=true'|grep -v grep| grep -v root 
ps -ef| grep -i  'java -DschedulercSrvc=true'|grep -v grep| grep -v root | awk '{print $2}' | xargs -r kill -9

ps -ef| grep -i  'java -DloginextwebhookSrvc=true'|grep -v grep| grep -v root 
ps -ef| grep -i  'java -DloginextwebhookSrvc=true'|grep -v grep| grep -v root | awk '{print $2}' | xargs -r kill -9




