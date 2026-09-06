# humanoid_navigation_stack

Test infrastructure for a simulated humanoid navigation stack: a G1
humanoid model, and (in progress) the sensor simulation, synchronization
monitoring, and fault-injection tooling built around it to exercise and
validate a robotics test/CI setup end to end.

This repo is the integration point, not a monolith: it holds the Docker
build environment and pulls in each package as a git submodule -- a
separate repo with its own history, README, tests, and CI. See each
submodule for what it actually does.

## Packages

| Package | Status | Repo |
|---|---|---|
| `unitree_g1_description` | done | [tiago369/unitree_g1_description](https://github.com/tiago369/unitree_g1_description) |
| `sensor_sim` | planned | -- |
| `sync_monitor` | planned | -- |
| `robot_control` | planned | -- |
| `fault_injector` | planned | -- |

## Why one repo per package instead of one big workspace

Each package is independently buildable, testable, and CI'd -- cloning
`humanoid_navigation_stack` pulls all of them in at pinned commits via
submodules, but any one of them stands on its own if that's all that's
needed.

## Why a Humble/Jazzy split

This repo's own [`docker/Dockerfile`](./docker/Dockerfile) targets ROS2
Jazzy / Ubuntu 24.04 -- the default for packages in this stack.
`src/unitree_g1_description` is the exception: it targets Humble instead, in
its own Dockerfile inside that repo, because its `unitree_ros2`
dependency is only tested against Foxy/Humble (see
[its README](https://github.com/tiago369/unitree_g1_description#why-a-separate-dockerfile-from-the-rest-of-the-metapackage)
for the full reasoning). It's built, tested, and CI'd standalone, and
deliberately excluded from this workspace's default build:

```bash
colcon build --packages-skip unitree_g1_description
```

## Setup

```bash
git clone --recurse-submodules https://github.com/tiago369/humanoid_navigation_stack.git
cd humanoid_navigation_stack
./scripts/docker_build.sh
./scripts/docker_run.sh
```

For `unitree_g1_description` specifically (its own Humble environment, MuJoCo
simulation, RViz), see the setup instructions in its own repo.

## Updating submodule pins

```bash
git submodule update --remote src/<package>
git add src/<package>
git commit -m "Bump <package> to latest"
```
