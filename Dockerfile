FROM phusion/passenger-ruby21:0.9.9

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.

RUN apt-get -y update
RUN apt-get -y install curl build-essential libxslt-dev libxml2-dev libmysql-ruby libmysqlclient-dev libpq-dev libsqlite3-dev libyaml-0-2 
RUN apt-get -y install libmagickwand-dev libmagickcore-dev libmagickcore4-extra libgraphviz-dev libgvc5

RUN cd /home/app && git clone https://github.com/opf/openproject.git

ADD database.yml /home/app/openproject/config/database.yml

RUN chown -R app:app /home/app/openproject

ENV RAILS_ENV production

RUN cd /home/app/openproject && sudo -u app -E -H bundle install --deployment

#NGINX delete all env variables by default
ADD nginx.conf /etc/nginx/nginx.conf

ADD openproject.conf /etc/nginx/sites-enabled/default

RUN rm -f /etc/service/nginx/down

ADD init_openproject /usr/local/bin/init_openproject

RUN apt-get -y install dnsmasq

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#DNSMASQ SERVICE
RUN mkdir /etc/service/dnsmasq
ADD dnsmasq.sh /etc/service/dnsmasq/run

CMD ["/sbin/my_init"]

VOLUME /home/app/openproject/config
VOLUME /home/app/openproject/files
