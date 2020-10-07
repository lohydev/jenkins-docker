FROM jenkins/jenkins:lts
USER root
ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

RUN apt-get update
RUN apt-get install --no-install-recommends -y apt-utils 2> >( grep -v 'debconf: delaying package configuration, since apt-utils is not installed' >&2 )
RUN apt-get install --no-install-recommends gnupg curl ca-certificates apt-transport-https software-properties-common -y
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
RUN apt-get update
RUN apt-get install docker-ce -y
