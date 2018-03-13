FROM centos:7.3.1611

MAINTAINER weiwei.luo <weiwei.luo@chinapnr.com>

ADD ./CentOS-Base.repo.tengxunyun /etc/yum.repos.d/CentOS-Base.repo

# create directory
RUN mkdir /root/app /root/source /root/www

# set config
ADD ./vimrc /root/.vimrc

# net-tools=ifconfig netstat
RUN yum install -y wget net-tools telnet bzip2 which gcc make zlib zlib-devel openssl openssl-devel

# install pip
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN rm -rf get-pip.py

# set pip.conf
RUN mkdir -p /root/.pip
ADD ./pip.conf /root/.pip/pip.conf

# set sys_time
RUN rm -rf /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# set utf-8
ENV LANG zh_CN.UTF-8
RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8

# set default path
WORKDIR /root

# install shadowsocks
RUN pip install shadowsocks

