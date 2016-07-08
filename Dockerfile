## -*- docker-image-name: "scaleway/sentry:latest" -*-
FROM scaleway/ubuntu:amd64-xenial
# following 'FROM' lines are used dynamically thanks do the image-builder
# which dynamically update the Dockerfile if needed.
#FROM scaleway/ubuntu:armhf-xenial       # arch=armv7l
#FROM scaleway/ubuntu:arm64-xenial       # arch=arm64
#FROM scaleway/ubuntu:i386-xenial        # arch=i386
#FROM scaleway/ubuntu:mips-xenial        # arch=mips


MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)


# Prepare rootfs for image-builder
RUN /usr/local/sbin/builder-enter

ENV DEBIAN_FRONTEND=noninteractive

# Install packages
RUN apt-get -q update \
 && echo "O" | apt-get -y -q upgrade \
 && apt-get install -y -q \
      python-setuptools \
      python-pip \
      python-dev \
      libxslt1-dev \
      libxml2-dev \
      libz-dev \
      libffi-dev \
      libjpeg-dev \
      libpq-dev \
      libssl-dev \
      libyaml-dev \
      rabbitmq-server \
      git \
      bc \
      postgresql \
      redis-server \
      nginx-full \
      postfix \
      supervisor \
 && apt-get clean

# Install Sentry
RUN pip install -U virtualenv \
 && virtualenv /www/sentry/ \
 && /bin/bash -c "source /www/sentry/bin/activate && pip install -U sentry==8.6.0"

# Patch rootfs
COPY ./overlay ./overlay-${ARCH} /


# Add sentry installation script
RUN update-rc.d sentry defaults


# Clean rootfs from image-builder
RUN /usr/local/sbin/builder-leave
