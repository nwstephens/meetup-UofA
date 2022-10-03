# Install cuda.ml

In order for {cuda.ml} to work as expected, the C++/CUDA source code of
{cuda.ml} must be linked with CUDA runtime and a valid copy of the RAPIDS cuML
library.

Before installing {cuda.ml} itself, it may be worthwhile to take a quick look
through the sub-sections below on how to properly setup all of {cuda.ml}'s
required runtime dependencies.

### Quick note on installing the RAPIDS cuML library:

Although Conda is the only officially supported distribution channel at the
moment for RAPIDS cuML (i.e., see https://rapids.ai/start.html#get-rapids),
you can still build and install this library from source without relying on
Conda.
See https://github.com/yitao-li/cuml-installation-notes for build-from-source
instructions.

### Quick install instructions for Ubuntu 20-04:

#### Install deps:
```
sudo apt install -y cmake ccache libblas3 liblapack3
```


### Install CUDA
(consult https://developer.nvidia.com/cuda-downloads for other platforms)
```bash
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.4.2/local_installers/cuda-repo-ubuntu2004-11-4-local_11.4.2-470.57.02-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2004-11-4-local_11.4.2-470.57.02-1_amd64.deb
sudo apt-key add /var/cuda-repo-ubuntu2004-11-4-local/7fa2af80.pub
sudo apt-get update
sudo apt-get -y install cuda
```
### Add CUDA executables to path
(nvcc is needed for building the C++/CUDA source code of {cuda.ml})
```bash
echo "export PATH=$PATH:/usr/local/cuda/bin" >> ~/.bashrc
source ~/.bashrc
```

### Install Miniconda:
```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh -b
# consult https://rapids.ai/start.html for alternatives
```

### Create and configure the conda env
```
# This is a relatively big download, may take a while
~/miniconda3/bin/conda create -n rapids-21.08 -c rapidsai -c nvidia -c conda-forge \
    rapids-blazing=21.08 python=3.8 cudatoolkit=11.2
```

### Install cmake
CUDA dependencies require a relatively recent version of CMake, so you need to install it manually
```bash
wget https://github.com/Kitware/CMake/releases/download/v3.22.0/cmake-3.22.0.tar.gz
cd cmake-3.22.0
./bootstrap && make -j8 && sudo make install
cd ..
```

### Activate the conda env:
```bash
. ~/miniconda3/bin/activate
conda activate rapids-21.08
```

### Consider adjusting `LD_LIBRARY_PATH`

The subsequent steps may (or may not) fail without the following:

```bash
export LD_LIBRARY_PATH=~/miniconda3/envs/rapids-21.08/lib
```

If you get some error indicating a GLIBC version mismatch in the subsequent
steps, then please try adjusting `LD_LIBRARY_PATH` as a workaround.


### Consider enabling ccache

To speed up recompilation times during development, set this env var:
```bash
echo "export CUML4R_ENABLE_CCACHE=1" >> ~/.bashrc
. ~/.bashrc
```

### Install {cuda.ml} the R package:

You can install the released version of {cuda.ml} from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("cuda.ml")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("mlverse/cuda.ml")
```
