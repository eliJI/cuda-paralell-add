#!/bin/bash

rm -rf ./streamtraces

cd /home/eingram4/Documents/cuda/pinsight/scripts
./trace.sh /home/eingram4/Documents/cuda/cuda-paralell-add/streamtraces streamtraces ../build/libpinsight.so /usr/local/cuda/lib64 /home/eingram4/Documents/cuda/cuda-paralell-add/main
