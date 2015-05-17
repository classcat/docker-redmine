FROM classcat/ubuntu-supervisord3:vivid
MAINTAINER ClassCat Co.,Ltd. <support@classcat.com>

########################################################################
# ClassCat/Redmine Dockerfile
#   Maintained by ClassCat Co.,Ltd ( http://www.classcat.com/ )
########################################################################

#--- HISTORY -----------------------------------------------------------
#-----------------------------------------------------------------------

WORKDIR /usr/local
RUN apt-get update && apt-get install -y libapache2-mod-passenger \
  && gem install bundler \
  && wget http://www.redmine.org/releases/redmine-3.0.1.tar.gz

WORKDIR /opt
COPY assets/cc-init.sh /opt/cc-init.sh

EXPOSE 22 80 443

CMD /opt/cc-init.sh; /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
