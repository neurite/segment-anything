#!/usr/bin/env bash

CONDA_PREFIX='envs/sam'

conda create -y -p ${CONDA_PREFIX} python=3.11

conda install -y -p ${CONDA_PREFIX} \
    requests tqdm regex ftfy jupyter \
    numpy scipy scikit-learn matplotlib pandas \
    pyarrow hdf5 pytables \
    pillow

${CONDA_PREFIX}/bin/pip install opencv-python pycocotools

### Install PyTorch, ONNX Runtime ###

# Note ONNX for model export is already in PyTorch

# Get the operating system name
OS_NAME=$(uname -s)

if [ ${OS_NAME} == "Darwin" ]; then
    echo "Installing PyTorch, ONNX Runtime for MacOS..."
    conda install -y -p ${CONDA_PREFIX} onnxruntime
    conda install -y -p ${CONDA_PREFIX} -c pytorch \
        pytorch=2.1.2 torchvision=0.16.2 
elif [ ${OS_NAME} == "Linux" ]; then
    echo "Installing PyTorch, ONNX Runtime for Linux..."
    echo "To be implemented."
    conda install -y -p ${CONDA_PREFIX} onnxruntime-gpu
else
    echo "Unsupported operating system: ${OS_NAME}"
fi

### Install SAM ###

${CONDA_PREFIX}/bin/pip install -e .

