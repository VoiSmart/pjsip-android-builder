FROM ubuntu:latest as jdk_image

ARG JDK_DIR=jdk1.8.0_211
ARG JDK_TAR=jdk-8u211-linux-x64.tar.gz

ENV JDK_DIR $JDK_DIR
ENV JDK_TAR $JDK_TAR

ENV PATH="/usr/lib/jvm/jdk1.8.0_211/bin:/usr/lib/jvm/jdk1.8.0_211/jre/bin:$PATH"
ENV J2SDKDIR="/usr/lib/jvm/jdk1.8.0_211"
ENV J2REDIR="/usr/lib/jvm/jdk1.8.0_211/jre"
ENV JAVA_HOME="/usr/lib/jvm/jdk1.8.0_211"

WORKDIR /home
COPY $JDK_TAR /home

RUN apt-get update && \
	apt-get install -y sudo && \
	apt-get install -y software-properties-common && \
	mkdir -p /usr/lib/jvm && \
	tar xzvf /home/jdk-8u211-linux-x64.tar.gz -C /usr/lib/jvm && \
	update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/$JDK_DIR/bin/java" 0 && \
	update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/$JDK_DIR/bin/javac" 0 && \
	update-alternatives --set java /usr/lib/jvm/$JDK_DIR/bin/java && \
	update-alternatives --set javac /usr/lib/jvm/$JDK_DIR/bin/javac

FROM jdk_image

WORKDIR /home
COPY . /home/

RUN ./prepare-build-system && \
	./build
