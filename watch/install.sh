#!/usr/local/bin/zsh
# Install watch

if [ ! -x `which watch` ]; then
  mkdir /tmp/burl \
    && cd /tmp/burl \
    && curl -L# https://github.com/mndvns/watch/archive/master.tar.gz | tar zx --strip 1 \
    && make install
fi
