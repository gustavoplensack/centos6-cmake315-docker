FROM ubuntu:18.04

# # Installing CMake inside the container image

RUN cd /usr/local/src \ 
    && N_JOBS=$(nproc) \
    && mkdir -p software \
    && cd software \
    && apt update \
    && apt install build-essential -y\
    && apt install wget  -y \
    && wget https://github.com/Kitware/CMake/releases/download/v3.15.7/cmake-3.15.7.tar.gz \
    && tar -xzf cmake-3.15.7.tar.gz \ 
    && cd cmake-3.15.7 \
    && ./bootstrap \
    && make -j "$N_JOBS"\
    && make install \
    && cd .. \
    && rm -rf cmake* \
    && cmake --version



RUN cd /usr/local/src/ \
    && N_JOBS=$(nproc) \
    && apt install -y zip \
    && wget https://dl.google.com/android/repository/android-ndk-r21-linux-x86_64.zip \
    && unzip android-ndk-r21-linux-x86_64.zip \
    && rm android-ndk-r21-linux-x86_64.zip


RUN apt install -y git
