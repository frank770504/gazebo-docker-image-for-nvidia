# This is an auto generated Dockerfile for gazebo:gzserver9
# generated from docker_images/create_gzserver_image.Dockerfile.em
FROM ubuntu:xenial

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2486D2DD83DB69272AFE98867170598AF249743

# setup sources.list
RUN . /etc/os-release \
    && . /etc/lsb-release \
    && echo "deb http://packages.osrfoundation.org/gazebo/$ID-stable $DISTRIB_CODENAME main" > /etc/apt/sources.list.d/gazebo-latest.list

# install gazebo packages
RUN apt-get update && apt-get install -q -y \
    gazebo9=9.0.0-1* \
    && rm -rf /var/lib/apt/lists/*

# setup environment
EXPOSE 11345

LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}
#ENV QT_DEVICE_PIXEL_RATIO=1

RUN bash -c 'echo "export QT_DEVICE_PIXEL_RATIO=1" >> /root/.bashrc'

# setup entrypoint
COPY ./gzserver_entrypoint.sh /

ENTRYPOINT ["/gzserver_entrypoint.sh"]
CMD ["gzserver"]
