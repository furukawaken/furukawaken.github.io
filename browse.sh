#!/bin/bash

set -e


# まずは既存プロセス掃除（任意の代表ポート）
for p in 4000 4001 35729 35730 49175; do
  pid=$(lsof -t -iTCP:$p -sTCP:LISTEN || true)
  [ -n "$pid" ] && echo "Killing $pid on :$p" && kill "$pid" || true
done

PORT=4001
LRPORT=49175  # 高番ポートに設定

# 使えなければ別ポートに逃がす
lsof -t -iTCP:$PORT -sTCP:LISTEN >/dev/null 2>&1 && PORT=4003
lsof -t -iTCP:$LRPORT -sTCP:LISTEN >/dev/null 2>&1 && LRPORT=49176

echo "Starting Jekyll on http://127.0.0.1:$PORT (livereload:$LRPORT)"
bundle exec jekyll serve --port "$PORT" --livereload --livereload-port "$LRPORT"

#for p in 4000 4001 35729 35730; do
#  pid=$(lsof -t -iTCP:$p -sTCP:LISTEN || true)
#  if [ -n "$pid" ]; then
#    echo "Killing process $pid on port $p"
#    kill "$pid" || true
#    sleep 1
#  fi
#done
#
#PORT=4000
#LRPORT=35729
#lsof -iTCP:$PORT -sTCP:LISTEN -t >/dev/null 2>&1 && PORT=4001
#lsof -iTCP:$LRPORT -sTCP:LISTEN -t >/dev/null 2>&1 && LRPORT=35730
#
#echo "Starting Jekyll on http://127.0.0.1:$PORT (livereload:$LRPORT)"
#bundle exec jekyll serve --livereload --port $PORT --livereload-port $LRPORT