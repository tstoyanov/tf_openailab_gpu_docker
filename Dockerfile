FROM nvidia/cuda:9.0-cudnn7-devel
LABEL maintainer="Todor Stoyanov"

# 0 installing CUDA all the way
WORKDIR /
#Installing Python, Jupyter, Tensorflow, OpenAI Gym
###################################################
# 1. installing python2 and python3
RUN apt-get update && \
	apt install -y --no-install-recommends python3-pip python-pip python3 python
# 1.1 uppgrade pip and pip3
RUN pip3 install --upgrade pip setuptools && pip install --upgrade pip

# 2. installing jupyter, and a bunch of Science Python Packages
# packages taken from https://hub.docker.com/r/jupyter/datascience-notebook/
RUN pip3 install jupyter pandas matplotlib scipy seaborn scikit-learn scikit-Image sympy cython patsy statsmodels cloudpickle dill numba bokeh

# 3. installing Tensorflow (GPU)
# see here https://www.tensorflow.org/install/install_linux#InstallingNativePip
RUN pip3 install tensorflow-gpu

# 4. Getting PoseCNN dependencies
#4.1 Pangolin
RUN apt-get update && apt-get install -y libeigen3-dev git cmake libglew-dev libboost-all-dev
RUN git clone https://github.com/stevenlovegrove/Pangolin.git && \
    mkdir Pangolin/build && \ 
    cd Pangolin/build && \
    cmake .. && \
    make -j4 && \
    make install
#4.2 
RUN git clone https://github.com/strasdat/Sophus.git && \
    apt-get update && apt-get install -y gfortran libc++-dev libgoogle-glog-dev libatlas-base-dev libsuitesparse-dev ccache wget 
    

# 5. installing X and xvfb so we can SEE the action using a remote desktop access (VNC)
# and because this is the last apt, let's clean up after ourselves
RUN apt-get update && apt-get install -y vim python-opengl python3-opengl
RUN apt-get install -y x11vnc xvfb fluxbox wmctrl && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* && \
		rm -rf /cudnn-8.0-linux-x64-v7.tgz && \
		rm -rf /cuda/


# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888
# VNC Server
EXPOSE 5900

COPY run.sh /
CMD ["/run.sh", "--allow-root"]
