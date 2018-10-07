FROM ubuntu:bionic
#FROM ubuntu:trusty

MAINTAINER Huy To Dac <todachuy2406@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update
RUN apt-get -y install wget wvdial usb-modeswitch

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

### EXPOSE 3306 
### ADD init_gammu.sh /init_gammu.sh

#Set environment variables.
ENV HOME /root
# Define working directory.
WORKDIR /root

CMD ["/bin/bash"]
### ENTRYPOINT [/bin/bash]
