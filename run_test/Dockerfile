# Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.
FROM kevmoo/dart-docker-content-shell

WORKDIR /app

ADD pubspec.yaml /app/
RUN pub get
ADD . /app/
RUN pub get --offline

ENTRYPOINT xvfb-run -s '-screen 0 1024x768x24' pub run test -p vm -p content-shell
