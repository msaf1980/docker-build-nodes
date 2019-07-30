FROM centos:7

ENV devtoolset_ver 8
ENV py_ver 36
ENV conan_ver 1.16.1
ENV conan_cmake_ver 3.15.1
ENV coverage_ver 4.4.2
ENV flake8_ver 3.5.0
ENV gcovr_ver 3.4

RUN yum -y install centos-release-scl epel-release
RUN yum install -y which wget zip unzip bzip2 doxygen findutils git graphviz
RUN yum install -y make autoconf automake cmake cmake3 rpm-build rpmdevtools
RUN yum install -y libpcap-devel lcov mpich-3.2-devel python-pip python-setuptools vim-common libtool perl
RUN yum install -y cloc cppcheck
RUN yum install -y clang-analyzer
RUN yum install -y rh-python${py_ver}
RUN yum install -y devtoolset-${devtoolset_ver}
RUN yum -y autoremove && yum clean all

RUN scl enable rh-python${py_ver} -- pip install --upgrade pip && \
    scl enable rh-python${py_ver} -- pip install conan==${conan_ver} coverage==${coverage_ver} flake8==${flake8_ver} gcovr==${gcovr_ver} && \
    rm -rf /root/.cache/pip/

ENV CONAN_USER_HOME=/conan

RUN mkdir $CONAN_USER_HOME && \
    scl enable rh-python${py_ver} conan

COPY files/registry.txt $CONAN_USER_HOME/.conan/

COPY files/default_profile $CONAN_USER_HOME/.conan/profiles/default

RUN scl enable rh-python${py_ver} -- conan install cmake_installer/${conan_cmake_ver}@conan/stable

RUN git clone https://github.com/ess-dmsc/build-utils.git && \
    cd build-utils && \
    git checkout 3643fdc0ccbcdf83d9366fa619a44a60e7df9414 && \
    scl enable devtoolset-6 -- make install

RUN mkdir -p ~/rpmbuild/BUILD \
         ~/rpmbuild/RPMS \
         ~/rpmbuild/RPMS/i{3,4,5,6}86 \
         ~/rpmbuild/RPMS/noarch \
         ~/rpmbuild/RPMS/x86_64 \
         ~/rpmbuild/SOURCES \
         ~/rpmbuild/SPECS \
         ~/rpmbuild/SRPMS

RUN echo ". /opt/rh/rh-python${py_ver}/enable" >> /etc/profile.d/devenv.sh
RUN echo ". /opt/rh/devtoolset-${devtoolset_ver}/enable" >> /etc/profile.d/devenv.sh

CMD ["bash"]
