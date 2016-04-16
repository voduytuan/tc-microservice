FROM voduytuan/docker-nginx-php:latest

RUN apt-get update 
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y python-setuptools python-pip

# Install supervisord
RUN easy_install supervisor

# install envtpl for replace
RUN pip install envtpl


# Copy startup script for getting environment information such as config...
ADD startup.sh      /var/startup.sh
RUN chmod +x /var/startup.sh

# tweak php-fpm config (base on 20MB/process and 8GB Memory)
RUN sed -i -e "s/pm.max_children = 5/pm.max_children = 400/g" /etc/php5/fpm/pool.d/www.conf && \
sed -i -e "s/pm.start_servers = 2/pm.start_servers = 8/g" /etc/php5/fpm/pool.d/www.conf && \
sed -i -e "s/pm.min_spare_servers = 1/pm.min_spare_servers = 4/g" /etc/php5/fpm/pool.d/www.conf && \
sed -i -e "s/pm.max_spare_servers = 3/pm.max_spare_servers = 12/g" /etc/php5/fpm/pool.d/www.conf && \
sed -i -e "s/;pm.max_requests = 500/pm.max_requests = 200/g" /etc/php5/fpm/pool.d/www.conf


# collectd config
#ADD collectd-config.conf.tpl /etc/collectd/configs/collectd-config.conf.tpl

# syslog-ng loggly config
ADD loggly.conf.tpl /etc/syslog-ng/conf.d/loggly.conf.tpl

# supervisord config
ADD supervisord.conf /etc/supervisord.conf

# create log directory for supervisord
RUN mkdir /var/log/supervisor/

# Create private folder for download config
RUN mkdir /var/www/private

CMD [ "/var/startup.sh" ]
