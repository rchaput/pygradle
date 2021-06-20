# PyGradle
> Author: rchaput

## Description

PyGradle is a Docker image that contains both Python3 and Gradle (Java), which can be used for multi-language applications.

This is in particular useful for Gitlab Runners which need to build such applications.

Note: this *liberica* version is based on the Alpine image from Bellsoft, which can be built on an AMD64 (x86-64) or an ARM64 (Apple Silicon) architecture.
Both architectures are available on the Docker Hub, and the one corresponding to your machine will be automatically downloaded, simply by using the `rchaput/pygradle:liberica` tag.

## List of included softwares/libraries

The image is based on `bellsoft/liberica-openjdk-alpine-musl:11`, and includes the following:
- Python
  + `python3`
  + `pip3`
  + `virtualenv`
- Java
  + `JDK11` (liberica version)
  + `Gradle` 7.1.0
- Other dependencies
  + `make`
  + `git`
  + `unzip`
  + `tar`
  + `gzip`
  + `openssh-client`

