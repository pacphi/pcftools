FROM ubuntu:bionic
LABEL author=cphillipson@pivotal.io

# Welcome to PCF-tools!
# This image installs the following versions of CLIs on an Ubuntu Xenial image

ENV BOSH_VERSION=5.4.0 \
    CF_VERSION=6.42.0 \
    CREDHUB_VERSION=2.2.1 \
    FLY_VERSION=4.2.2 \
    OM_VERSION=0.51.0 \
    PIVNET_VERSION=0.0.55

# In addition it will install the latest available versions of: jq, git, ruby-dev, cf-uaac

RUN apt update && \
      apt install build-essential curl git jq ruby-dev sudo wget -y && \
      useradd -m docker && echo "docker:docker" | chpasswd && \
      adduser docker sudo && \
      gem install cf-uaac && \
      wget https://github.com/cloudfoundry/bosh-cli/releases/download/v${BOSH_VERSION}/bosh-cli-${BOSH_VERSION}-linux-amd64 && \
      mv bosh-cli-${BOSH_VERSION}-linux-amd64 bosh && \
      chmod +x bosh && \
      sudo mv bosh /usr/local/bin && \
      wget -O cf.tgz "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=${CF_VERSION}&source=github-rel" && \
      tar -xvf cf.tgz && \
      sudo mv cf /usr/local/bin && \
      wget https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/${CREDHUB_VERSION}/credhub-linux-${CREDHUB_VERSION}.tgz && \
      tar -xvzf credhub-linux-${CREDHUB_VERSION}.tgz && \
      sudo mv credhub /usr/local/bin && \
      wget https://github.com/concourse/concourse/releases/download/v${FLY_VERSION}/fly_linux_amd64 && \
      mv fly_linux_amd64 fly && \
      chmod +x fly && \
      sudo mv fly /usr/local/bin && \
      wget https://github.com/pivotal-cf/om/releases/download/${OM_VERSION}/om-linux && \
      mv om-linux om && \
      chmod +x om && \
      sudo mv om /usr/local/bin && \
      wget https://github.com/pivotal-cf/pivnet-cli/releases/download/v${PIVNET_VERSION}/pivnet-linux-amd64-${PIVNET_VERSION} && \
      mv pivnet-linux-amd64-${PIVNET_VERSION} pivnet && \
      chmod +x pivnet && \
      sudo mv pivnet /usr/local/bin

USER docker

CMD /bin/bash