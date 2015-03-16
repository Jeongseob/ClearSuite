#!/bin/bash
## File: Data-Caching/start-client.sh
## Usage: start-client.sh [RPS] [file path]
## Author: Yunqi Zhang (yunqi@umich.edu)
## Modified by Jeongseob Ahn

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 [RPS] [file path]"
	exit 1
fi

BENCHMARK="Data-Caching"

RPS=$1
OUTPUT=$2

# Change directory
cd "$BENCHMARK-Client"/memcached/memcached_client

# Get hardware configuration
NUM_CORE=`grep -c ^processor /proc/cpuinfo`
echo "[$BENCHMARK] The machine has $NUM_CORE logical cores in total."

# Run the test
echo "[$BENCHMARK] Run the test with 80% GET forever and $NUM_CORE threads."
# Configure memcached loader

# NOTE: it does not consider NUMA affinity
cmd="unbuffer ./loader -a ../twitter_dataset/twitter_dataset_30x \
	  -s servers.txt -g 0.8 -T 10 -c 256 -w $NUM_CORE"

# Check rps parameter
if [ $RPS != '0' ]; then
	cmd="$cmd -r $RPS"
fi

$cmd > "$OUTPUT"
