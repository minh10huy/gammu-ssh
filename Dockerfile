FROM ubuntu:trusty

MAINTAINER Huy To Dac <todachuy2406@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update
RUN apt-get -y install supervisor wget wvdial usb-modeswitch openssh-server

### Install SSH ###
ADD start-sshd.sh /start-sshd.sh
RUN chmod +x /start-sshd.sh
ADD supervisord-sshd.conf /etc/supervisor/conf.d/supervisord-sshd.conf
RUN mkdir /var/run/sshd
RUN echo 'root:changemeplease' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
###################

RUN apt-get -y install software-properties-common
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 80E7349A06ED541C
RUN apt-key update
RUN DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:nijel/ppa
RUN apt-get -y update
RUN apt-get -y install --allow-unauthenticated --quiet --yes --force-yes gammu gammu-smsd
RUN wget -q https://raw.githubusercontent.com/minh10huy/gammu-smsdrc/master/gammu-smsdrc -O /etc/gammu-smsdrc
RUN wget -q https://raw.githubusercontent.com/minh10huy/gammu-smsdrc/master/gammurc -O /etc/gammurc
RUN sed -i 's/USER\=gammu/USER\=root/g' /etc/init.d/gammu-smsd

RUN apt-get -y install python-pip

EXPOSE 22
ADD start-supervisor.sh /start-supervisor.sh
RUN chmod +x /start-supervisor.sh

#Set environment variables.
ENV HOME /root
# Define working directory.
WORKDIR /root

CMD ["/start-supervisor.sh"]
### ENTRYPOINT [/bin/bash]
