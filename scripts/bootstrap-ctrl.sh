#!/usr/bin/env bash

apt-get update && apt-get -y install software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update && apt-get -y install ansible

# configure hosts file for our internal network defined by Vagrantfile
cat >> /etc/hosts <<EOL
# vagrant environment hosts
10.0.15.30  ansible-controller
10.0.15.40  jenkins-ci
10.0.15.41  jenkins-ci-test
EOL

# create new ssh key
[[ ! -f /home/vagrant/.ssh/jenkins_rsa ]] \
&& ssh-keygen -t rsa -b 2048 -f /home/vagrant/.ssh/jenkins_rsa -N '' \
&& chown -R vagrant:vagrant /home/vagrant/.ssh