FROM ubuntu:22.04

ENV conan_ver 1.16.1
ENV conan_cmake_ver 3.15.1
ENV coverage_ver 4.4.2
ENV flake8_ver 3.5.0
ENV gcovr_ver 3.4
ENV markupsafe_ver 2.0.1

RUN apt-get update -y
RUN apt-get install -y byobu curl git  unzip wget automake autoconf cmake apt-utils m4 libtool 
# libevent-dev libonig-dev 
RUN apt-get install -y gcc g++ gdb
RUN apt-get install -y cloc cppcheck
RUN apt-get install -y clang-14 clang++-14
RUN apt-get install -y clang-tidy
RUN apt-get install -y python3-pip
RUN apt-get clean -y

RUN pip3 install --upgrade setuptools astroid && \
    pip3 install conan==${conan_ver} coverage==${coverage_ver} flake8==${flake8_ver} gcovr==${gcovr_ver} markupsafe==${markupsafe_ver} && \
    rm -rf /root/.cache/pip/*

RUN git clone https://github.com/ess-dmsc/build-utils.git && \
    cd build-utils && \
    git checkout 3643fdc0ccbcdf83d9366fa619a44a60e7df9414 && \
    make install

#RUN conan install cmake_installer/${conan_cmake_ver}@conan/stable
