#!/usr/bin/env bash
set -euo pipefail

ENV_FILE="./secret/env.json"

DEFINES=$(jq -r '
  to_entries
  | map("--dart-define=\(.key)=\(.value|tostring)")
  | join(" ")
' "$ENV_FILE")

echo "COMMAND: flutter run $DEFINES"

flutter run $DEFINES
