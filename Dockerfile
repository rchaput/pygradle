FROM debian:stable-slim

LABEL maintainer="Remy Chaput <rchaput.pro@pm.me>"
LABEL version="1.0"
LABEL description="Docker image containing both Python3 and Java/Gradle"

# Install system dependencies (both for installing Java/Gradle and for later)
ENV JAVA_DEPS="curl ca-certificates openssl tar gzip"
ENV GRADLE_DEPS="unzip"
ENV OTHER_DEPS="make git openssh-client"
RUN apt update && \
	apt install -y --no-install-recommends ${JAVA_DEPS} ${GRADLE_DEPS} ${OTHER_DEPS} 

# Install Java 8 (OpenJ9 for smaller size)
ENV JAVA_URL https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u265-b01_openj9-0.21.0/OpenJDK8U-jdk_x64_linux_openj9_8u265b01_openj9-0.21.0.tar.gz
ENV JAVA_HOME /opt/java
ENV PATH="/opt/java/bin:${PATH}"
RUN curl -sSL "${JAVA_URL}" -o openjdk.tar.gz && \
	mkdir -p "${JAVA_HOME}" && \
	tar xzvf openjdk.tar.gz -C "${JAVA_HOME}" --strip-components=1 && \
	rm openjdk.tar.gz && \
	java -version

# Install Gradle
ENV GRADLE_HOME /opt/gradle
ENV GRADLE_VERSION 7.1
RUN curl -sSL "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" -o gradle.zip && \
	unzip gradle.zip && \
	rm gradle.zip && \
	mv "gradle-${GRADLE_VERSION}" "${GRADLE_HOME}/" && \
	ln --symbolic "${GRADLE_HOME}/bin/gradle" /usr/bin/gradle && \
	gradle --version

# Install Python3
RUN apt install -y --no-install-recommends python3 python3-pip && \
	pip3 install virtualenv && \
	python3 --version

# Clean apt cache
RUN apt clean && \
	rm -rf /var/lib/apt/lists/*

# Bugfix? Replace dash with bash (so `set -o pipefail` will work in gitlab-runner)
RUN ln --symbolic --force /bin/bash /bin/sh
SHELL ["/bin/bash", "-c"]
ENTRYPOINT ["/bin/bash", "-c"]
