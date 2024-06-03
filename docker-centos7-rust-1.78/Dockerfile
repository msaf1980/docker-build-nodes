FROM centos:7

ARG rust_version=1.78.0
ARG py_ver=36
ARG ruby_ver=30

RUN yum -y install centos-release-scl epel-release
RUN yum install -y which wget zip unzip bzip2 doxygen findutils git graphviz \
                   make autoconf automake cmake cmake3 rpm-build rpmdevtools
RUN yum install -y gcc gcc-c++
RUN yum install -y libpcap-devel lcov mpich-3.2-devel python-pip python-setuptools vim-common libtool perl
RUN yum install -y rh-python${py_ver}
RUN yum install -y rh-ruby${ruby_ver} rh-ruby${ruby_ver}-ruby-devel rh-ruby${ruby_ver}-rubygem-rake

RUN yum -y autoremove && yum clean all

RUN pip install --upgrade pip && \
    pip install --upgrade setuptools

RUN rpm -i https://github.com/goreleaser/nfpm/releases/download/v0.9.5/nfpm_amd64.rpm
RUN . /opt/rh/rh-ruby${ruby_ver}/enable && gem install fpm

RUN curl https://static.rust-lang.org/dist/rust-${rust_version}-x86_64-unknown-linux-gnu.tar.xz | tar -xJf -
RUN ./rust-${rust_version}-x86_64-unknown-linux-gnu/install.sh && rm -rf rust-${rust_version}-x86_64-unknown-linux-gnu rust-${rust_version}-x86_64-unknown-linux-gnu.tar.gz

RUN mkdir -p ~/rpmbuild/BUILD \
         ~/rpmbuild/RPMS \
         ~/rpmbuild/RPMS/i{3,4,5,6}86 \
         ~/rpmbuild/RPMS/noarch \
         ~/rpmbuild/RPMS/x86_64 \
         ~/rpmbuild/SOURCES \
         ~/rpmbuild/SPECS \
         ~/rpmbuild/SRPMS

RUN echo ". /opt/rh/rh-python${py_ver}/enable" >> ${HOME}/.profile
RUN echo ". /opt/rh/rh-ruby${ruby_ver}/enable" >> ${HOME}/.profile

ENV PATH="$HOME/.cargo/bin:${PATH}"

CMD [ "bash" ]
