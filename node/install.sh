# Install n

if test ! (( $+commands[n] )); then
  mkdir /tmp/n && cd /tmp/n && curl -L# https://github.com/visionmedia/n/archive/master.tar.gz | tar zx --strip 1 && make install
fi

# Install node

if test ! (( $+commands[node] )); then
  n latest
fi

# Install useful deps

npm install -g serve
npm install -g mocha
npm install -g nr
