These install all CUDA-enabled dependencies via pip.\
( requirements-jax-cuda.txt, requirements-tensorflow-cuda.txt, requirements-torch-cuda.txt )\
They expect a NVIDIA driver to be preinstalled.\
We recommend a clean python environment for each backend\
to avoid CUDA version mismatches.\

As an example, here is how to create a JAX GPU environment with Conda:

```bash
conda create -y -n keras-jax python=3.10
conda activate keras-jax
pip install -r requirements-jax-cuda.txt
pip install --upgrade keras
```
