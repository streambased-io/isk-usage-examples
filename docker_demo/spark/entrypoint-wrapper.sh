#!/bin/bash
echo -e "cat <<END_OF_TEXT\n$(cat /opt/spark/conf/spark-defaults.template)\nEND_OF_TEXT" | bash >>  /opt/spark/conf/spark-defaults.conf
notebook