FROM sacharya/apache
MAINTAINER Sudarshan Acharya <info@sacharya.com>

RUN apt-get update && \
 DEBIAN_FRONTEND=noninteractive apt-get -y upgrade && \
 DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor && \
 apt-get -y install mysql-client

ENV APP_ROOT /app

ADD http://wordpress.org/latest.tar.gz wordpress.tar.gz
RUN tar xzf wordpress.tar.gz -C $APP_ROOT --strip-components 1
RUN rm wordpress.tar.gz

ADD wp-config.php $APP_ROOT/wp-config.php
RUN chmod 644 $APP_ROOT/wp-config.php
RUN chown -R www-data:www-data $APP_ROOT

ADD run.sh run.sh
RUN chmod 755 /*.sh

EXPOSE 80
CMD ["/run.sh"]


