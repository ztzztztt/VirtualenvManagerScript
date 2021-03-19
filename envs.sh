#!/bin/bash

ENV_PATH="/home/chase/Virtualenvs"
ENV_LIST=$(ls -l $ENV_PATH | awk '/^d/ {print $NF}')

# 重新生成环境变量
function refreshEnvs(){
    sed -i '/bin\/activate/d' ~/.bashrc
    # 获取所有的文件夹
    for name in $(ls -l $ENV_PATH | awk '/^d/ {print $NF}')
    do
        echo "Envs: $name"
        echo "alias $name='source $ENV_PATH/$name/bin/activate'" >> ~/.bashrc
    done
    source ~/.bashrc
}


function lsEnvs(){
    # 获取所有的文件夹
    echo "Total Envs: $(ls -l $ENV_PATH | grep '^d'| wc -l)"
    for name in $(ls -l $ENV_PATH | awk '/^d/ {print $NF}')
    do
        echo "Envs: $name"
    done
}


function contains(){
    # echo $1 $2
    for env in [ $1 ]
    do
        # echo $env
        if [ $env == $2 ]; then
            echo "y"
            return 0
        fi
    done

    echo "n"
    return 1
}

# 单命令参数
if [ $# -eq 1 ]; then
    if [ $1 == "r" ] || [ $1 == "refresh" ]; then
        echo "Refresh Virtualenvs"
        refreshEnvs
    elif [ $1 == "l" ] || [ $1 == "ls" ]; then
    	lsEnvs
    fi
elif [ $# -eq 2 ]; then
    if [ $1 == "d" ] || [ $1 == "delete" ]; then
        if [ $(contains "${ENV_LIST[@]}" "$2") == "y" ]; then
            echo "Delete Virtualenv: $2"
            rm -rf "$ENV_PATH/$2"
            refreshEnvs
        else
            echo "$2 Envs is not exist"
        fi
    elif [ $1 == "a" ] || [ $1 == "add" ]; then
        if [ $(contains "${ENV_LIST[@]}" "$2") == "n" ]; then
            virtualenv $ENV_PATH/$2
            lsEnvs
        else
            echo "$2 Envs is exists"
        fi
    fi
    ENV_LIST=()
else
    echo "Enter option: bash envs.sh options
    options:
	- l/ls: list all virtualenvs
	- r/refresh: refresh virtualenvs
	- a n/add name: add virtualenv n
	- d n/delete name: delete virtualenv n"
fi




