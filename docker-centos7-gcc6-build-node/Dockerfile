FROM centos7-gcc6:latest

RUN adduser jenkins

RUN chown -R jenkins $CONAN_USER_HOME/.conan

USER jenkins

WORKDIR /home/jenkins

CMD ["/usr/bin/scl", "enable", "rh-python35", "devtoolset-6", "/bin/bash"]
