#!/bin/bash

set -e

# 既存の Jekyll / LiveReload を止める
for p in 4000 4001 35729 35730; do
  pid=$(lsof -t -iTCP:$p -sTCP:LISTEN || true)
  if [ -n "$pid" ]; then
    echo "Killing process $pid on port $p"
    kill "$pid" || true
    sleep 1
  fi
done

# デフォルト: 4000 / 35729 が空いてなければ代替ポートに
PORT=4000
LRPORT=35729
lsof -iTCP:$PORT -sTCP:LISTEN -t >/dev/null 2>&1 && PORT=4001
lsof -iTCP:$LRPORT -sTCP:LISTEN -t >/dev/null 2>&1 && LRPORT=35730

echo "Starting Jekyll on http://127.0.0.1:$PORT (livereload:$LRPORT)"
bundle exec jekyll serve --livereload --port $PORT --livereload-port $LRPORT