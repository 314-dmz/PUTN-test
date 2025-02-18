# 使用官方的 ROS 镜像作为基础镜像
FROM ros:noetic-ros-base

# 设置工作目录
WORKDIR /putn_ws
# 复制当前目录下的文件到容器中
COPY . /putn_ws/src

# 安装依赖
RUN apt-get update && \
    rosdep install --from-paths src --ignore-src -y

# 构建 ROS 包
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && \
                  catkin_make"

# 设置环境变量
ENV ROS_MASTER_URI=http://localhost:11311
ENV ROS_HOSTNAME=localhost

# 设置默认启动命令
CMD ["roslaunch", "putn_launch", "simulation.launch"]