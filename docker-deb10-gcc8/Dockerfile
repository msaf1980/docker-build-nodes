FROM debian:10

ENV conan_ver 1.16.1
ENV conan_cmake_ver 3.15.1
ENV coverage_ver 4.4.2
ENV flake8_ver 3.5.0
ENV gcovr_ver 3.4

RUN apt-get update
RUN apt-get install -y --allow-unauthenticated --no-install-recommends wget zip unzip bzip2 findutils file ca-certificates curl libcurl4 pkg-config git
RUN apt-get install -y --allow-unauthenticated make autoconf automake cmake
RUN apt-get install -y --allow-unauthenticated build-essential gcc g++ gdb
RUN apt-get install -y --allow-unauthenticated python-pip python-setuptools
RUN apt-get install -y --allow-unauthenticated python3 python3-pip python3-setuptools

#RUN apt-get install -y --allow-unauthenticated ruby ruby-dev
#RUN rpm -i https://github.com/goreleaser/nfpm/releases/download/v0.9.5/nfpm_amd64.rpm
#RUN gem install fpm

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#RUN pip3 install --upgrade pip
RUN pip3 install conan==${conan_ver} coverage==${coverage_ver} flake8==${flake8_ver} gcovr==${gcovr_ver} && \
    rm -rf /root/.cache/pip/

RUN conan install cmake_installer/${conan_cmake_ver}@conan/stable

RUN git clone https://github.com/ess-dmsc/build-utils.git && \
    cd build-utils && \
    git checkout 3643fdc0ccbcdf83d9366fa619a44a60e7df9414 && \
    make install

CMD ["bash"]
