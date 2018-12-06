FROM centos:7

ENV RUST_VERSION 1.30.1

RUN yum -y install centos-release-scl epel-release
RUN yum install -y which wget zip unzip bzip2 findutils git
RUN yum install -y make autoconf automake cmake cmake3 rpm-build
RUN yum install -y gcc gcc-c++
RUN yum install -y ruby-devel
RUN yum -y autoremove && yum clean all

RUN rpm -i https://github.com/goreleaser/nfpm/releases/download/v0.9.5/nfpm_amd64.rpm
RUN gem install fpm

RUN curl https://static.rust-lang.org/dist/rust-${RUST_VERSION}-x86_64-unknown-linux-gnu.tar.gz | tar -xzf -
RUN ./rust-${RUST_VERSION}-x86_64-unknown-linux-gnu/install.sh && rm -rf rust-${RUST_VERSION}-x86_64-unknown-linux-gnu rust-${RUST_VERSION}-x86_64-unknown-linux-gnu.tar.gz

RUN mkdir -p ~/rpmbuild/BUILD \
         ~/rpmbuild/RPMS \
         ~/rpmbuild/RPMS/i{3,4,5,6}86 \
         ~/rpmbuild/RPMS/noarch \
         ~/rpmbuild/RPMS/x86_64 \
         ~/rpmbuild/SOURCES \
         ~/rpmbuild/SPECS \
         ~/rpmbuild/SRPMS

CMD ["/bin/bash"]
