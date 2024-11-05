conda create -n atmol python=3.7
qsub -P col870.course -q standard -lselect=1:ncpus=1:ngpus=1:centos=skylake -lwalltime=1:00:00 -I
conda activate atmol
conda install pytorch torchvision torchaudio pytorch-cuda=11.7 -c pytorch -c nvidia
conda install pyg -c pyg
conda install pytorch-scatter -c pyg
conda install pytorch-sparse -c pyg
conda install pytorch-cluster -c pyg
conda install pytorch-spline-conv -c pyg
conda install tornado
conda install tqdm
conda install pandas
conda install matplotlib
conda install numpy
conda install scikit-learn
conda install rdkit
conda install deepchem=2.6.0
conda install networkx