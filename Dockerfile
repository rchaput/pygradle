FROM bellsoft/liberica-openjdk-alpine-musl:11

LABEL maintainer="Remy Chaput"
LABEL version="1.1"
LABEL description="Docker image containing both Python3 and Java/Gradle"

# Install system dependencies (both for installing Java, Gradle, Python and for later)
ENV OTHER_DEPS="make git openssh-client"
RUN apk update && \
	apk add ${OTHER_DEPS}

# Install Gradle
ENV GRADLE_VERSION=7.1
ENV GRADLE_HOME /opt/gradle
RUN wget "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" -O gradle.zip && \
	unzip gradle.zip && \
	rm gradle.zip && \
	mv "gradle-${GRADLE_VERSION}" "${GRADLE_HOME}/" && \
	ln -s "${GRADLE_HOME}/bin/gradle" /usr/bin/gradle && \
	gradle --version

# Install Python3
RUN apk add python3 py3-pip && \
	pip3 install virtualenv && \
	python3 --version

# Clean cache
RUN rm -rf /var/cache/apk*

SHELL ["/bin/sh", "-c"]
ENTRYPOINT ["/bin/sh", "-c"]
