# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.10

MAINTAINER Aaron Ott <aaron.ott@gmail.com>

# Set correct environment variables.
ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

ADD ssh_keys /tmp/ssh_keys
RUN cat /tmp/ssh_keys >> /root/.ssh/authorized_keys && rm -f /tmp/ssh_keys

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main restricted universe multiverse" > /etc/apt/sources.list
RUN apt-get update

# Basic Requirements
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server mysql-client pwgen python-setuptools curl git unzip

RUN apt-get clean

# Make mysql listen on the outside
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Supervisor Config
RUN /usr/bin/easy_install supervisor
ADD ./supervisord.conf /etc/supervisord.conf

# Drupal Initialization and Startup Script
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh

# private expose
EXPOSE 3306

CMD ["/bin/bash", "/start.sh"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
