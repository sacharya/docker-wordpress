FROM ubuntu:14.04
MAINTAINER Sudarshan Acharya <info@sacharya.com>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

RUN apt-get install -y mysql-server
ADD my.cnf /etc/mysql/conf.d/my.cnf 
ADD run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

VOLUME ["/var/lib/mysql"]
CMD ["/usr/local/bin/run"]
