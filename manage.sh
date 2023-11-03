#!/usr/bin/env bash

if [ "$1" = "new" ]
then
    touch ./pages/$2.md
    nvim ./pages/$2.md
elif [ "$1" = "edit" ]
then
    nvim ./pages/$2.md
elif [ "$1" = "delete" ]
then
    rm ./pages/$2.md
fi
