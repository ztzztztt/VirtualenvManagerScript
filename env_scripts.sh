#!/bin/bash


ENV_PATH="/home/chase/Virtualenvs"

# 删除指定的环境字符串
sed -i '/bin\/activate/d' ~/.bashrc

# 获取所有的文件夹
for name in $(ls -l $ENV_PATH | awk '/^d/ {print $NF}')
do
    echo $name
    echo "alias $name='source $ENV_PATH/$name/bin/activate'" >> ~/.bashrc
done

source ~/.bashrc
