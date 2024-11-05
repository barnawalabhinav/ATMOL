#!/usr/bin/expect -f

# Start the interactive job
spawn qsub -I -q high -P col870.course -l select=1:ncpus=1:ngpus=1:centos=icelake:mem=64 -l walltime=10:00:00

# Wait for the prompt in the interactive session
expect "$ "

# Send the commands to run in the interactive job terminal
send "cd ~/COL870/ATMOL\r"
send "conda activate atmol\r"
send "source ~/setup_proxy.sh logout\r"
send "source ~/setup_proxy.sh &> proxy.log &\r"
send "source ~/export_proxy.sh\r"
# sleep 10
# send "wget www.google.com\r"
# curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -
send "python main_pretrain.py --batch_size 512 --epochs 500 --datafile in-vitro\r"
send "python main_pretrain.py --batch_size 512 --epochs 500 --datafile now\r"
send "python main_clr_downstream.py --batch_size 128 --epochs 500 --dataset MUV\r"

# Interact with the session to keep it open
interact

## *********************************************** ##
## TO RUN THIS FILE RUN: expect pbs_interactive.sh ##
## *********************************************** ##
