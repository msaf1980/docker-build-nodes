FROM centos:7

RUN yum -y install centos-release-scl epel-release
RUN yum install -y which wget zip unzip bzip2 doxygen findutils git graphviz
RUN yum install -y make autoconf automake cmake cmake3 rpm-build rpmdevtools
RUN yum install -y cloc cppcheck
RUN yum install -y clang-analyzer devtoolset-6
RUN yum install -y libpcap-devel lcov mpich-3.2-devel rh-python35 vim-common libtool perl
RUN yum -y autoremove && yum clean all

RUN scl enable rh-python35 -- pip install --force-reinstall pip==9.0.3 && \
    scl enable rh-python35 -- pip install conan==1.3.3 coverage==4.4.2 flake8==3.5.0 gcovr==3.4 && \
    rm -rf /root/.cache/pip/*

ENV CONAN_USER_HOME=/conan

RUN mkdir $CONAN_USER_HOME && \
    scl enable rh-python35 conan

COPY files/registry.txt $CONAN_USER_HOME/.conan/

COPY files/default_profile $CONAN_USER_HOME/.conan/profiles/default

RUN scl enable rh-python35 -- conan install cmake_installer/3.10.0@conan/stable

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

CMD ["/usr/bin/scl", "enable", "rh-python35", "devtoolset-6", "/bin/bash"]
