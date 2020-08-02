FROM ubuntu:20.04

RUN apt update \
    && apt upgrade -y \
    && apt install curl gnupg git -y \
    && curl -f https://bazel.build/bazel-release.pub.gpg | apt-key add - \
    && echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list \
    && apt update \
    && apt install bazel -y \
    && apt clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*