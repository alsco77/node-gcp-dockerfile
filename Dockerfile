
# Use the base App Engine Docker image, based on Ubuntu 16.0.4.
FROM gcr.io/gcp-runtimes/ubuntu_16_0_4:latest

RUN echo "deb http://packages.cloud.google.com/apt cloud-sdk-stretch main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
  && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

# Install updates and dependencies
RUN apt-get update -y && \
  apt-get install --no-install-recommends -y -q \
  apt-utils \
  google-cloud-sdk \
  apt-transport-https \
  build-essential \
  ca-certificates \
  curl \
  git \
  imagemagick \
  libkrb5-dev \
  netbase \
  python && \
  apt-get upgrade -y && \
  apt-get clean && \
  rm /var/lib/apt/lists/*_*


RUN curl --silent --location https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install --yes nodejs

ENV PATH $PATH:/nodejs/bin


# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main"  >> /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y -q yarn && \
  mkdir -p /opt/yarn/bin && \
  ln -s /usr/bin/yarn /opt/yarn/bin/yarn