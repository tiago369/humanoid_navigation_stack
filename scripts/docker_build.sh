#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$SCRIPT_DIR/.."
IMAGE_TAG="${IMAGE_TAG:-humanoid-navigation-stack:jazzy}"

docker build -f "$REPO_ROOT/docker/Dockerfile" -t "$IMAGE_TAG" "$REPO_ROOT"
echo "Built $IMAGE_TAG"
