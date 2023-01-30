#!/usr/bin/env bash

debug_message(){
    msg="$1"

    if [ "$DEBUG" == "true" ];then
        echo "$msg"
    fi
}