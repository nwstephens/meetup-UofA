# Install Torch

Since version 0.1.1 torch supports GPU installation on Windows. In order to use GPU’s with torch you need to:

* Have a CUDA compatible NVIDIA GPU. You can find if you have a CUDA compatible GPU here.
* Have properly installed the NVIDIA CUDA toolkit version 11.3. For CUDA v11.3, follow the installation instructions here. Note: The version of the CUDA toolkit must match exactly what’s mentioed above.
* Have installed cuDNN version cuDNN 8.4. Follow the installation instructions available here.

Once you have installed all pre-requisites you can install torch with:
```
install.packages("torch")
```
If you have followed default installation locations we will detect that you have CUDA software installed and automatically download the GPU enabled Lantern binaries. You can also specify the CUDA env var with something like Sys.setenv(CUDA="11.3") if you want to force an specific version of the CUDA toolkit.
