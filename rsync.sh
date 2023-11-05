#!/usr/bin/env bash
rsync -uvrP --delete-after ./static/* root@www.alexkunze.xyz:/var/www/alexkunze/
