#!/bin/sh

function check_url(){
    wget --spider -q -o /dev/null  --tries=1 -T 5 $1
    if [ $? -eq 0 ]
        then
            action "$1 is ok !" /bin/true
    else
            action "$1 is bad !" /bin/false
    fi
}

check_url $1