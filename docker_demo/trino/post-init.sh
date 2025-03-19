#!/bin/bash

nohup /usr/lib/trino/bin/run-trino &

sleep 10

tail -f /dev/null