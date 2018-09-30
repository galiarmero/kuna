#!/usr/bin/env bash

function install_git {
    GIT="git"
    IS_GIT_INSTALLED=$(dpkg-query -W --showformat='${Status}\n' $GIT | grep "install ok installed")
    if [ "" == "$IS_GIT_INSTALLED" ]; then
        sudo apt-get install -y $GIT
    else
        echo "$GIT is already installed."
    fi
}

function install_node {
    NODE="nodejs"
    IS_NODE_INSTALLED=$(dpkg-query -W --showformat='${Status}\n' $NODE | grep "install ok installed")
    if [ "" == "$IS_NODE_INSTALLED" ]; then
        # Install Node.js v10.x with NPM
        curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
        sudo apt-get install -y $NODE
    else
        echo "$NODE is already installed."
    fi
}

function install_mongo {
    MONGO="mongodb-org"
    IS_MONGO_INSTALLED=$(dpkg-query -W --showformat='${Status}\n' $MONGO | grep "install ok installed")
    if [ "" == "$IS_MONGO_INSTALLED" ]; then
        sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
        echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
        sudo apt-get update
        sudo apt-get install -y $MONGO
    else
        echo "$MONGO is already installed."
    fi
}

function install_docker {
    DOCKER="docker-ce"
    IS_DOCKER_INSTALLED=$(dpkg-query -W --showformat='${Status}\n' $DOCKER | grep "install ok installed")
    if [ "" == "$IS_DOCKER_INSTALLED" ]; then
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
        sudo apt-get update
        sudo apt-get install -y $DOCKER
        sudo usermod -aG docker vagrant # add user 'vagrant' to 'docker' group
    else
        echo "$DOCKER is already installed."
    fi
}

function install_docker_compose {
    IS_DOCKER_COMPOSE_INSTALLED=$(command -v docker-compose)
    if [ "" == "$IS_DOCKER_COMPOSE_INSTALLED" ]; then
        sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
    else
        echo "docker-compose is already installed."
    fi
}

function start_mongo {
    sudo systemctl start mongod
    sudo systemctl enable mongod
}

# install packages
sudo apt-get update
install_git
install_node
install_mongo
install_docker
install_docker_compose

# start services
start_mongo
