FROM centos:centos6.10

# # Installing CMake inside the container image
RUN cd /usr/local/src \ 
    && N_JOBS=$(nproc) \
    && mkdir -p software \
    && cd software \
    && yum -y install centos-release-scl \ 
    && yum -y install git \
    && yum -y install devtoolset-7 \
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
