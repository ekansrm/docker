#!/bin/bash

cd $(dirname $0)

db_docker_name=$1

db_docker_volume_root=${PWD}/${db_docker_name}

db_docker_mountpoint=("/var/lib/mysql")

# 生成挂载目录参数
db_docker_mount_arg=""
for mountpoint in ${db_docker_mountpoint[@]} 
do
    mkdir -p ${db_docker_volume_root}${mountpoint}
    db_docker_mount_arg="${db_docker_mount_arg} -v ${db_docker_volume_root}${mountpoint}:${mountpoint}"
done
db_docker_mount_arg="${db_docker_mount_arg} -p 3306:3306 --name $1 -P -e mysqld -e MYSQL_ROOT_PASSWORD=rm19223ewkl -e MYSQL_USER=test -e MYSQL_PASSWORD=test -e MYSQL_DATABASE=testDb --restart=on-failure:10"

# 建立容器
docker run -it ${db_docker_mount_arg} mysql 

