#!/bin/bash

lmao=$(cat ./pages/test.md)

sed "s/stylesheet/$lmao/" about.html
