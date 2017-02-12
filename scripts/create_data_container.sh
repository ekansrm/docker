#!/bin/bash

cd $(dirname $0)

db_docker_name=$1

db_docker_volume_root=${PWD}/${db_docker_name}

db_docker_mountpoint=("/var/lib/mysql" "/opt/pyspider")

db_docker_mount_arg=""
for mountpoint in ${db_docker_mountpoint[@]} 
do
    mkdir -p ${db_docker_volume_root}${mountpoint}
    db_docker_mount_arg="${db_docker_mount_arg} -v ${db_docker_volume_root}${mountpoint}:${mountpoint}"
done

docker run --rm -it ${db_docker_mount_arg} busybox
