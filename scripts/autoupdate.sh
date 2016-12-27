#! /bin/bash

source nginx
source token

phonelockfile="phone.lock"
iplockfile="ip.lock"

ipversion=$(curl "http://user.ipip.net/download.php?a=version&token=$IPTOKEN" 2>/dev/null)
iplock=$(cat "$iplockfile")

echo "compare ip version now:$iplock future:$ipversion"

if [[ "$iplock" != "$ipversion" ]]; then
    wget -O ../fixtures/real_ip.datx "http://user.ipip.net/download.php?type=datx&token=$IPTOKEN"

    if [[ $? == 0 ]]; then
        (cd ../ && make test)

        if [[ $? == 0 ]]; then

            if $NGINX -t; then
                echo "ready reload nginx"
                $NGINX -s reload
                echo "$ipversion" > "$iplockfile"
            fi
        fi
    fi
fi

phoneversion=$(curl "http://user.ipip.net/download.php?a=version&token=$PHONETOKEN" 2>/dev/null)

phonelock=$(cat "$phonelockfile")

echo "compare phone version now:$phonelock future:$phoneversion"

if [[ "$phonelock" != "$phoneversion" ]]; then
    wget -O ../fixtures/real_phone.txt "http://user.ipip.net/download.php?token=$PHONETOKEN"

    if [[ $? == 0 ]]; then
        (cd ../ && make test)

        if [[ $? == 0 ]]; then

            if $NGINX -t; then

                echo "ready reload nginx"
                $NGINX -s reload
                echo "$phoneversion" > "$phonelockfile"
            fi
        fi
    fi

fi
