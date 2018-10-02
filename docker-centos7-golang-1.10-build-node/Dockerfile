FROM centos:7

ENV GO_VER 1.10.4
ENV GODEP_VER 0.5.0

RUN yum -y install centos-release-scl epel-release
RUN yum install -y which wget zip unzip bzip2 doxygen findutils git graphviz
RUN yum install -y make autoconf automake cmake cmake3 rpm-build
RUN yum install -y gcc gcc-c++ gdb
RUN yum install -y rh-python35 vim-common libtool perl
RUN yum -y autoremove && yum clean all

RUN scl enable rh-python35 -- pip install --force-reinstall pip==9.0.3 && \
    rm -rf /root/.cache/pip/*

RUN wget https://dl.google.com/go/go${GO_VER}.linux-amd64.tar.gz && \
    tar -xzf go${GO_VER}.linux-amd64.tar.gz -C /usr/local && \
    ln -s /usr/local/go/bin/go /usr/local/bin/go && \
    ln -s /usr/local/go/bin/godoc /usr/local/bin/godoc && \
    ln -s /usr/local/go/bin/godoc /usr/local/bin/gofmt
    
RUN wget https://github.com/golang/dep/releases/download/v${GODEP_VER}/dep-linux-amd64 -O /usr/local/bin/dep && \
    chmod +x /usr/local/bin/dep

RUN adduser jenkins

USER jenkins

WORKDIR /home/jenkins

CMD ["/bin/bash"]
