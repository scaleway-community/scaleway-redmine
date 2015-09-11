## -*- docker-image-name: "scaleway/redmine:latest" -*-
FROM scaleway/ubuntu:trusty
MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)

# Prepare rootfs for image-builder
RUN /usr/local/sbin/builder-enter

# Upgrade packages
RUN apt-get -q update \
  && apt-get --force-yes -y -qq upgrade \
  && apt-get install -y -qq \
    ruby-dev \
    apache2 \
    mysql-server-5.5 \
    libmysqlclient-dev
    libapache2-mod-passenger \
    postfix \
    zlib1g-dev \
    imagemagick \
    libmagickwand-dev \
    git \
    subversion \
    cvs \
    mercurial

# Install Redmine

ENV REDMINE_VERSION 3.0.4

RUN gem update && gem install bundler

RUN wget http://www.redmine.org/releases/redmine-$REDMINE_VERSION.tar.gz \
  && tar -xzf redmine-$REDMINE_VERSION.tar.gz -C /usr/share/ \
  && mv /usr/share/redmine-$REDMINE_VERSION /usr/share/redmine \
  && cd /usr/share/redmine \
  && bundle install --without development test
  && rake generate_secret_token \
  && mkdir -p tmp public/plugin_assets \
  && chown -R www-data:www-data files log tmp public/plugin_assets \
  && chmod -R 755 files log tmp public/plugin_assets
  && cd /var/www/html && ln -s /usr/share/redmine .


# Patches
ADD patches/etc/ /etc/
ADD patches/usr/ /usr/
ADD patches/root/ /root/

RUN /etc/init.d/mysql start \
  && mysql -u root -e "CREATE DATABASE redmine CHARACTER SET utf8;" \
  && cd /usr/share/redmine \
  && RAILS_ENV=production rake db:migrate \
  && echo en | RAILS_ENV=production rake redmine:load_default_data \
  && /etc/init.d/mysql stop


# Clean rootfs from image-builder
RUN /usr/local/sbin/builder-leave
