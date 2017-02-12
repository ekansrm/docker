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
# docker run -it ${db_docker_mount_arg} mysql 
# 动态获取参数
# echo $@
container_name=""
mysql_username=""
mysql_password=""
mysql_root_password=""
for arg in $@
do
    arg=${arg##*-}
    case ${arg%%=*} in 
        container_name) container_name=${arg#*=};;
        mysql_username) mysql_username=${arg#*=};;
        mysql_password) mysql_password=${arg#*=};;
        mysql_root_password) mysql_root_password=${arg#*=};;
        *) echo -e "\e[1;31m[Warning]Invaild arg: ${arg%%=*} \e[0m";;
    esac
done


#read -p "Input the name of container: " container_name
#read -p "Input the username of mysql: " mysql_username
#read -p "Input the password of mysql: " mysql_password
#read -p "Input the root password of mysql: " mysql_root_password

echo ${container_name} 
echo ${mysql_username}
echo ${mysql_password}
echo ${mysql_root_password}



