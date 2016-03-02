#!/bin/sh

yum install -y git make autoconf automake gcc svn rpm-build gem ruby-devel

rm -rf zabbix*
mkdir zabbix30
cd zabbix30
svn co svn://svn.zabbix.com/branches/3.0 .
./bootstrap.sh
./configure --enable-agent

mkdir -p src/modules/zabbix_module_docker
cd src/modules/zabbix_module_docker
cp ../../../../../src/modules/zabbix_module_docker/* .
make

gem install fpm
mkdir -p usr/lib/modules
cp zabbix_module_docker.so usr/lib/modules
fpm -s dir -t rpm -n "zabbix_module_docker" -v 0.5.0 usr

cd ../../../..
cp zabbix30/src/modules/zabbix_module_docker/zabbix_module_docker*.rpm .
rm -rf zabbix30
