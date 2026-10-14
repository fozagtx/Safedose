#!/usr/bin/env sh
# Builds the Flutter web app into onedose_server/web/app, where the server
# serves it. Run before building the Docker image or deploying.
set -eu
cd "$(dirname "$0")/../onedose_flutter"
rm -rf ../onedose_server/web/app
flutter build web --release --base-href / --output ../onedose_server/web/app
