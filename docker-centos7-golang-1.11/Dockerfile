FROM centos:7

ENV GO_VER 1.11.11
ENV GODEP_VER 0.5.0
ENV py_ver 36
ENV conan_ver 1.16.1
ENV coverage_ver 4.4.2
ENV flake8_ver 3.5.0
ENV gcovr_ver 3.4

RUN yum -y install centos-release-scl epel-release
RUN yum install -y which wget zip unzip bzip2 doxygen findutils git graphviz
RUN yum install -y make autoconf automake cmake cmake3 rpm-build rpmdevtools
RUN yum install -y gcc gcc-c++ gdb
RUN yum install -y rh-python${py_ver} vim-common libtool perl
RUN yum install -y ruby-devel
RUN yum -y autoremove && yum clean all

RUN scl enable rh-python${py_ver} -- pip install --upgrade pip && \
    scl enable rh-python${py_ver} -- pip install conan==${conan_ver} coverage==${coverage_ver} flake8==${flake8_ver} gcovr==${gcovr_ver} && \
    rm -rf /root/.cache/pip/*

RUN wget https://dl.google.com/go/go${GO_VER}.linux-amd64.tar.gz && \
    tar -xzf go${GO_VER}.linux-amd64.tar.gz -C /usr/local && \
    ln -s /usr/local/go/bin/go /usr/local/bin/go && \
    ln -s /usr/local/go/bin/godoc /usr/local/bin/godoc && \
    ln -s /usr/local/go/bin/godoc /usr/local/bin/gofmt
    
RUN wget https://github.com/golang/dep/releases/download/v${GODEP_VER}/dep-linux-amd64 -O /usr/local/bin/dep && \
    chmod +x /usr/local/bin/dep

RUN rpm -i https://github.com/goreleaser/nfpm/releases/download/v0.9.5/nfpm_amd64.rpm
# newer fpm is broken https://github.com/jordansissel/fpm/issues/1612
RUN    gem install rake fpm:1.10.2

RUN mkdir -p ~/rpmbuild/BUILD \
         ~/rpmbuild/RPMS \
         ~/rpmbuild/RPMS/i{3,4,5,6}86 \
         ~/rpmbuild/RPMS/noarch \
         ~/rpmbuild/RPMS/x86_64 \
         ~/rpmbuild/SOURCES \
         ~/rpmbuild/SPECS \
         ~/rpmbuild/SRPMS \
         ~/go/src/github.com

ENV PATH="${HOME}/go/bin:${PATH}"

CMD ["/usr/bin/scl", "enable", "rh-python${py_ver}", "/bin/bash"]
