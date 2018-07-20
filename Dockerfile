FROM ruby:2.2
MAINTAINER Felipe Caldas <caldas@gmail.com>

RUN apt-get update
RUN apt-get --yes upgrade

RUN apt-get --yes install git-core curl zlib1g-dev build-essential \
                     libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 \
                     libxml2-dev libxslt1-dev libcurl4-openssl-dev \
                     python-software-properties libffi-dev \
					           software-properties-common python-software-properties wget

RUN apt-add-repository -y ppa:rwky/redis
RUN apt-add-repository 'deb http://www.rabbitmq.com/debian/ testing main'
RUN curl http://www.rabbitmq.com/rabbitmq-signing-key-public.asc | apt-key add -
#RUN apt-get update

RUN apt-get --yes install redis-server

RUN apt-get --yes --allow-unauthenticated install rabbitmq-server

RUN rabbitmq-plugins enable rabbitmq_management

RUN apt-get --yes install build-essential chrpath git-core libssl-dev libfontconfig1-dev
RUN cd /usr/local/share
ENV PHANTOMJS_VERISON=1.9.8
#RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERISON-linux-x86_64.tar.bz2
#RUN tar xjf phantomjs-$PHANTOMJS_VERISON-linux-x86_64.tar.bz2
#RUN ln -s /usr/local/share/phantomjs-$PHANTOMJS_VERISON-linux-x86_64/bin/phantomjs /usr/local/share/phantomjs
#RUN ln -s /usr/local/share/phantomjs-$PHANTOMJS_VERISON-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs
#RUN ln -s /usr/local/share/phantomjs-$PHANTOMJS_VERISON-linux-x86_64/bin/phantomjs /usr/bin/phantomjs

RUN apt-get --yes install imagemagick

#RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get --yes install nodejs

#RUN wget http://localhost:15672/cli/rabbitmqadmin
#RUN chmod +x rabbitmqadmin
#RUN mv rabbitmqadmin /usr/local/sbin

RUN cd ~
RUN git clone https://github.com/zouzehe/peatio.git
RUN mkdir -p ~/.bitcoin
RUN cp ./peatio/config/bitcoin.conf ~/.bitcoin/bitcoin.conf
RUN cp ./peatio/script/startup /root
RUN chmod +x /root/startup

WORKDIR ./peatio
RUN bundle update json
RUN bundle install

EXPOSE 3000:3000
