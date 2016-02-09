FROM debian:jessie
MAINTAINER "Christian Kniep <christian@qnib.org>"

RUN echo "2015-10-27.1";apt-get update && \
     apt-get install -y supervisor && \
     echo "supervisord -c /etc/supervisord.conf" >> /root/.bash_history && \
     echo "supervisorctl status" >> /root/.bash_history && \
     echo "tail -f /var/log/supervisor/" >> /root/.bash_history 
## Dumb-init
RUN apt-get install -y wget && \
    wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.0.0/dumb-init_1.0.0_amd64 && \
    chmod +x /usr/local/bin/dumb-init
#ENTRYPOINT /usr/local/bin/dumb-init
ADD etc/supervisord.conf /etc/supervisord.conf
ADD opt/qnib/supervisor/bin/start.sh /opt/qnib/supervisor/bin/
CMD ["opt/qnib/supervisor/bin/start.sh", "-n"]

