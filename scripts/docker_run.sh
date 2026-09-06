#!/usr/bin/env bash
set -euo pipefail

# src/ is bind-mounted (not baked in at build time) since it holds git
# submodules that get added/updated independently of the image -- see
# docker_run.sh in src/unitree_g1_description for the same pattern, and why
# --network host / X11 forwarding are here (DDS discovery, RViz).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$SCRIPT_DIR/.."
IMAGE_TAG="${IMAGE_TAG:-humanoid-navigation-stack:jazzy}"
CONTAINER_NAME="${CONTAINER_NAME:-humanoid_navigation_stack_dev}"

echo "Tip: once inside, open more shells into this same container from"
echo "another terminal with: docker exec -it $CONTAINER_NAME bash"
echo "Note: src/unitree_g1_description targets Humble and is not buildable"
echo "here -- see its own docker/ for that. Build everything else with:"
echo "  colcon build --packages-skip unitree_g1_description"

docker run -it --rm \
  --name "$CONTAINER_NAME" \
  --network host \
  --env DISPLAY="${DISPLAY:-}" \
  --volume /tmp/.X11-unix:/tmp/.X11-unix \
  --volume "$REPO_ROOT/src:/ws/src" \
  "$IMAGE_TAG" \
  /bin/bash
