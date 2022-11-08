FROM centos:7

ARG golang_version
ENV godep_ver 0.5.0
ENV py_ver 36
ENV ruby_ver 27
ENV conan_ver 1.16.1
ENV coverage_ver 4.4.2
ENV flake8_ver 3.5.0
ENV gcovr_ver 3.4

RUN yum -y install centos-release-scl epel-release 
RUN yum -y install centos-release-scl-rh centos-release-scl
RUN yum install -y which wget zip unzip bzip2 doxygen findutils git graphviz \
                   make autoconf automake cmake cmake3 rpm-build rpmdevtools
RUN yum install -y gcc gcc-c++
RUN yum install -y libpcap-devel lcov mpich-3.2-devel python-pip python-setuptools vim-common libtool perl
RUN yum install -y rh-python${py_ver}
RUN yum install -y rh-ruby${ruby_ver} rh-ruby${ruby_ver}-ruby-devel rh-ruby${ruby_ver}-rubygem-rake
RUN yum -y autoremove && yum clean all

RUN scl enable rh-python${py_ver} -- pip install --upgrade pip && \
    scl enable rh-python${py_ver} -- pip install conan==${conan_ver} coverage==${coverage_ver} flake8==${flake8_ver} gcovr==${gcovr_ver} && \
    rm -rf /root/.cache/pip/*

RUN wget -q https://dl.google.com/go/go${golang_version}.linux-amd64.tar.gz && \
    tar -xzf go${golang_version}.linux-amd64.tar.gz -C /usr/local && \
    ln -s /usr/local/go/bin/go /usr/local/bin/go && \
    ln -s /usr/local/go/bin/godoc /usr/local/bin/godoc && \
    ln -s /usr/local/go/bin/godoc /usr/local/bin/gofmt

RUN wget -q https://github.com/golang/dep/releases/download/v${godep_ver}/dep-linux-amd64 -O /usr/local/bin/dep && \
    chmod +x /usr/local/bin/dep

RUN rpm -i https://github.com/goreleaser/nfpm/releases/download/v0.9.5/nfpm_amd64.rpm
# newer fpm is broken https://github.com/jordansissel/fpm/issues/1612
#RUN    gem install childprocess:0.9.0 fpm:1.10.2
# Qiuck and ugly fpm replacement
RUN . /opt/rh/rh-ruby${ruby_ver}/enable && gem install rake childprocess:0.9.0 childprocess:0.9.0 fpm

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

CMD [ "scl", "enable", "rh-python36", "rh-ruby27", "bash" ]
