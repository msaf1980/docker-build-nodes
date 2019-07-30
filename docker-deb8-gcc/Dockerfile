FROM debian:8

RUN apt-get update
RUN apt-get install -y --no-install-recommends wget zip unzip bzip2 findutils file ca-certificates curl libcurl3 pkg-config git
RUN apt-get install -y make autoconf automake cmake
RUN apt-get install -y build-essential gcc g++ gdb
RUN apt-get install -y ruby-dev

#RUN rpm -i https://github.com/goreleaser/nfpm/releases/download/v0.9.5/nfpm_amd64.rpm
RUN gem install fpm

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["bash"]
