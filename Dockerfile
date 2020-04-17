FROM i386/debian:jessie

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
