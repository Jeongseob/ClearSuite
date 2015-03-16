#!/bin/sh
## Usage: measure_your_memecached_server.sh [execution time][max_rps] 
## Author: Jeongseob Ahn
 
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 [timeout] [max_rps]"
	exit 1
fi

TIMEOUT=$1
MAX_RPS=$2

# Measure Memcached from 5% to 100% of max_rps
for i in `seq 0.05 0.05 1.0`;
do
	rps=`echo "($i*$MAX_RPS)" | bc | awk '{printf("%.0f", $0)}'`
	timeout $TIMEOUT ./start-client.sh $rps rps_$rps
done 
