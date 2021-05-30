# PyGradle
> Author: rchaput

## Description

PyGradle is a Docker image that contains both Python3 and Gradle (Java), which can be used for multi-language applications.

This is in particular useful for Gitlab Runners which need to build such applications.

## List of included softwares/libraries

The image is based on `debian/stable-slim`, and includes the following:
- Python
  + `python3`
  + `pip3`
  + `virtualenv`
- Java
  + `JDK8` (OpenJ9 version)
  + `Gradle` 6.6.1
- Other dependencies
  + `make`
  + `git`
  + `unzip`
  + `tar`
  + `gzip`
  + `openssh-client`
  + `curl`

