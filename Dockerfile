FROM classcat/ubuntu-supervisord3:vivid
MAINTAINER ClassCat Co.,Ltd. <support@classcat.com>

########################################################################
# ClassCat/Redmine Dockerfile
#   Maintained by ClassCat Co.,Ltd ( http://www.classcat.com/ )
########################################################################

#--- HISTORY -----------------------------------------------------------
#-----------------------------------------------------------------------

WORKDIR /usr/local
RUN apt-get update \
  && apt-get install -y libapache2-mod-passenger \
       ruby1.9.1-dev ruby2.1-dev build-essential zlib1g-dev \
       imagemagick libmagickwand-dev libmysqlclient-dev \
  && gem install bundler \
  && wget http://www.redmine.org/releases/redmine-3.0.1.tar.gz \
  && tar xfz redmine-3.0.1.tar.gz \
  && chown -R root.root /usr/local/redmine-3.0.1

COPY assets/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY assets/passenger.conf /etc/apache2/mods-available/passenger.conf

WORKDIR /opt
COPY assets/cc-init.sh /opt/cc-init.sh

EXPOSE 22 80 443

CMD /opt/cc-init.sh; /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
