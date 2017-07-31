#!/usr/bin/sh
PROCESS="process name shown in ps -ef"
START_OR_STOP=1        # 0 = start | 1 = stop

MAX=3
COUNT=0

until [ $COUNT -gt $MAX ] ; do
        echo -ne "."
        PROCESS_NUM=$(ps -ef|grep tomcat|grep -v grep | awk '{print $2}')
        if [ $PROCESS_NUM -gt 0 ]; then
            #runs
            RET=1
        else
            #stopped
            RET=0
        fi

        if [ $RET -eq $START_OR_STOP ]; then
            sleep 5 #wait...
        else
            if [ $START_OR_STOP -eq 1 ]; then
                    echo -ne " stopped"
            else
                    echo -ne " started"
            fi
            echo
            exit 0
        fi
        let COUNT=COUNT+1
done

if [ $START_OR_STOP -eq 1 ]; then
    echo -ne " !!server is UP!!" |mailx -s "Tomcat is UP $(date)" kirantech58@gmail.com 
else
    echo -ne " !!server is Down!!"|mailx -s "Tomcat is Down $(date)" kirantech58@gmail.com
fi
echo
exit 1
