#!/bin/bash

IP=$1
mtr -r -c3 -w -b -p -j $IP
