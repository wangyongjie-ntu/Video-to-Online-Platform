#!/usr/bin/env bash

BASE_DIR=${PWD}

# update submodules
git submodules update --init --recursive

# install Conda virtual environment
conda env create -y -f environment.yml

# compile decode module
cd "${BASE_DIR}"/hysia/core/HysiaDecode || return 1
# if the nvidia driver is lower than 396, uncomment below
# make CPU_ONLY=TRUE
# otherwise
make clean && make CPU_ONLY=TRUE

# build mmdect
cd "${BASE_DIR}"/third || return 1
chmod +x ./compile.sh
./compile.sh

# build server
cd "${BASE_DIR}"/server || return 1
chmod +x ./reset-db.sh
./reset-db.sh
