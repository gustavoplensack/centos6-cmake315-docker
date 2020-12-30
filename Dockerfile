FROM centos:centos7

# Install CMake and useful software, like git
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

# Install pip and AWS-CLI
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python2.7 get-pip.py \
    && rm get-pip.py \
    && pip install awscli

# Add "source /opt/rh/devtoolset-7/enable" to root's ~/.bashrc
RUN echo "source /opt/rh/devtoolset-7/enable" >> ~/.bashrc