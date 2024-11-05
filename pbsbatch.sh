#!/bin/sh
### Set the job name (for your reference)
#PBS -N atmol
### Set the project name, your department code by default
#PBS -P col870.course
### Request email when job begins and ends, don't change anything on the below line 
#PBS -m bea
### Specify email address to use for notification, don't change anything on the below line
#PBS -M $USER@iitd.ac.in
#### Request your resources, just change the numbers
#PBS -l select=1:ncpus=1:ngpus=1:centos=icelake
### Specify "wallclock time" required for this job, hh:mm:ss
#PBS -l walltime=10:00:00
#PBS -l software=PYTHON
#PBS -q high

# After job starts, must goto working directory. 
# $PBS_O_WORKDIR is the directory from where the job is fired. 
echo "==============================="
echo $PBS_JOBID
cat $PBS_NODEFILE
echo "==============================="
cd $PBS_O_WORKDIR
echo $PBS_O_WORKDIR

# module () {
#         eval `/usr/share/Modules/$MODULE_VERSION/bin/modulecmd bash $*`
# }

module load apps/anaconda/3
source activate ~/miniconda3/envs/atmol
module unload apps/anaconda/3

# nohup bash -c "source ~/setup_proxy.sh" &> proxy.log &
# bash -c "source ~/setup_proxy.sh" &> proxy.log &
source ~/setup_proxy.sh &> proxy.log &
source ~/export_proxy.sh

wget www.google.com
# python main_clr_downstream.py --batch_size 128 --epochs 500 --dataset BBBP
# python main_clr_downstream.py --batch_size 128 --epochs 500 --dataset HIV
# python main_clr_downstream.py --batch_size 128 --epochs 500 --dataset BACE
# python main_clr_downstream.py --batch_size 128 --epochs 500 --dataset Tox21
# python main_clr_downstream.py --batch_size 128 --epochs 500 --dataset ClinTox
# python main_clr_downstream.py --batch_size 128 --epochs 500 --dataset SIDER
python main_clr_downstream.py --batch_size 128 --epochs 500 --dataset MUV