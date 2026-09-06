# Default build environment for humanoid_navigation_stack packages.
#
# ROS2 Jazzy / Ubuntu 24.04. This is the default for the stack, NOT for
# every package in it: src/robot_description targets ROS2 Humble instead,
# in its own Dockerfile, because its unitree_ros2 dependency is only
# tested against Foxy/Humble (see src/robot_description/README.md). It is
# built and tested standalone, and deliberately skipped here.
FROM osrf/ros:jazzy-desktop

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-colcon-common-extensions \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN echo "source /opt/ros/jazzy/setup.bash" >> /root/.bashrc && \
    echo "[ -f /ws/install/setup.bash ] && source /ws/install/setup.bash" >> /root/.bashrc

WORKDIR /ws
CMD ["/bin/bash"]
