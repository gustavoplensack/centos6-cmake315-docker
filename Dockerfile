FROM ubuntu:18.04

# # Installing CMake inside the container image
RUN cd /usr/local/src \ 
    && N_JOBS=$(nproc) \
    && mkdir -p software \
    && cd software \
    && apt -y update \ 
    && apt -y install git \
    && apt -y buil devtoolset-7 \
    && source /opt/rh/devtoolset-7/enable \
    && yum install wget -y \
    && wget https://github.com/Kitware/CMake/releases/download/v3.15.7/cmake-3.15.7.tar.gz \
    && tar -xzvf cmake-3.15.7.tar.gz \ 
    && cd cmake-3.15.7 \
    && ./bootstrap \
    && make -j "$N_JOBS"\
    && make install \
    && cd .. \
    && rm -rf cmake*

RUN cd /usr/local/src/ \
    && N_JOBS=$(nproc) \
    && apt install -y zip \
    && wget https://dl.google.com/android/repository/android-ndk-r16b-linux-x86_64.zip \
    && unzip android-ndk-r16b-linux-x86_64.zip