# CUDA + TensorFlow + OpenAI Gym + Jupyter

This project hosts a Dockerimage that let's you run TensorFlow code to compete in the OpenAI Gym. And because we are all beginners here, let's not assume our Python code is perfect from the start --> Jupyter to the rescue.

Based on a fork from pascalwhoop/tf_openailab_gpu_docker.

## Size of the image
This image is quiet large. It's because it contains

- CUDA
- FFMPEG 
- Lots of Python packages
- x11 xvfb etc so we can SEE the action with VNC
- gcc and g++ compilers for C code
- is Ubuntu based

## Dependencies

You just need a machine with Docker, Nvidia-Docker and the nvidia drivers. 

## installation

```
#builds and runs the image, binding your path to the container, so you can access them from jupyter
./build.sh path/to/your/notebooks 
```

## Important links

- [Nvidia Docker CUDA base Image](https://gitlab.com/nvidia/cuda)
- [Jupyter Docs to Start Notebooks](https://jupyter.readthedocs.io/en/latest/running.html)
- [TensorFlow Install instructions](https://www.tensorflow.org/install/install_linux)
