# Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.
FROM ubuntu:12.04

MAINTAINER Kevin Moore "github@j832.com"

RUN echo "deb http://us.archive.ubuntu.com/ubuntu precise main multiverse" >> /etc/apt/sources.list
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ precise contrib non-free" >> /etc/apt/sources.list
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ precise-updates contrib non-free" >> /etc/apt/sources.list
RUN apt-get update; echo 'true'

# Pre-accepts MSFT Fonts EULA:
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections

# Install all dependencies:
RUN apt-get install --no-install-recommends -y -q chromium-browser libudev0 \
  ttf-kochi-gothic ttf-kochi-mincho ttf-mscorefonts-installer ttf-indic-fonts \
  ttf-dejavu-core ttf-indic-fonts-core fonts-thai-tlwg msttcorefonts xvfb \
  curl git ca-certificates apt-transport-https unzip \
  ttf-indic-fonts \
  ttf-dejavu-core ttf-kochi-gothic ttf-kochi-mincho \
  ttf-thai-tlwg

# It seems I have to pre-set HOME to use it in the ENV DART_SDK setting below
ENV HOME /root
#ENV DART_VERSION 1.12.0-dev.4.0.0
#ENV CHANNEL dev
ENV CHANNEL stable
ENV DART_VERSION 1.11.1.0
ENV archive_url https://storage.googleapis.com/dart-archive/channels/$CHANNEL/release/latest

RUN curl $archive_url/sdk/dartsdk-linux-x64-release.zip > $HOME/dartsdk.zip
RUN unzip $HOME/dartsdk.zip -d $HOME > /dev/null
RUN rm $HOME/dartsdk.zip
ENV DART_SDK $HOME/dart-sdk
ENV PATH $DART_SDK/bin:$PATH
ENV PATH $HOME/.pub-cache/bin:$PATH

RUN mkdir $HOME/content_shell
WORKDIR $HOME/content_shell
RUN curl $archive_url/dartium/content_shell-linux-x64-release.zip > content_shell.zip
RUN unzip content_shell.zip > /dev/null
RUN rm content_shell.zip
ENV PATH $HOME/content_shell/drt-lucid64-full-$CHANNEL-$DART_VERSION:$PATH

WORKDIR $HOME
