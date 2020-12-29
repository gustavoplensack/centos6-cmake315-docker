FROM ubuntu:18.04

# Install CMake
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


# Install android NDK
RUN cd /usr/local/src/ \
    && N_JOBS=$(nproc) \
    && apt install -y zip \
    && wget https://dl.google.com/android/repository/android-ndk-r21-linux-x86_64.zip \
    && unzip android-ndk-r21-linux-x86_64.zip \
    && rm android-ndk-r21-linux-x86_64.zip

# Install git, curl and python3.6
RUN apt install -y git curl python3.6-dev python3-distutils python3-apt

# Install pip and AWS-CLI
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python3.6 get-pip.py \
    && pip install awscli
