FROM ubuntu:bionic
LABEL author=cphillipson@pivotal.io

# Welcome to PCF-tools!
# This image installs the following versions of CLIs on an Ubuntu Xenial image

ENV BOSH_VERSION=5.4.0 \
    CF_VERSION=6.42.0 \
    CREDALERT_VERSION=2018-12-07-21-29-15 \
    CREDHUB_VERSION=2.2.1 \
    FLY_VERSION=4.2.2 \
    KUBECTL_VERSION=1.13.0 \
    OM_VERSION=0.51.0 \
    PIVNET_VERSION=0.0.55 \
    TERRAFORM_VERSION=0.11.11

# In addition it will install the latest available versions of: aws, az, cf-uaac, gcloud, git, jq, kubectl, ruby-dev

RUN mkdir downloads && cd downloads && \
      apt update && \
      apt install build-essential curl git jq python-pip python-dev ruby-dev sudo wget -y && \
      apt install apt-transport-https lsb-release software-properties-common dirmngr -y && \
      sudo pip install --upgrade pip && \
      sudo pip install --upgrade virtualenv && \
      useradd -m docker && echo "docker:docker" | chpasswd && \
      adduser docker sudo && \
      pip install awscli && \
      export AZ_REPO=$(lsb_release -cs) && \
      echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
        sudo tee /etc/apt/sources.list.d/azure-cli.list && \
      sudo apt-key --keyring /etc/apt/trusted.gpg.d/Microsoft.gpg adv \
        --keyserver packages.microsoft.com \
        --recv-keys BC528686B50D79E339D3721CEB3E94ADBE1229CF && \
      sudo apt update && \
      sudo apt install azure-cli && \
      export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
      echo "deb http://packages.cloud.google.com/apt ${CLOUD_SDK_REPO} main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
      curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
      apt update -y && apt install google-cloud-sdk -y && \
      gem install cf-uaac && \
      wget https://github.com/cloudfoundry/bosh-cli/releases/download/v${BOSH_VERSION}/bosh-cli-${BOSH_VERSION}-linux-amd64 && \
      mv bosh-cli-${BOSH_VERSION}-linux-amd64 bosh && \
      chmod +x bosh && \
      sudo mv bosh /usr/local/bin && \
      wget -O cf.tgz "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=${CF_VERSION}&source=github-rel" && \
      tar -xvf cf.tgz && \
      sudo mv cf /usr/local/bin && \
      wget https://github.com/pivotal-cf/cred-alert/releases/download/${CREDALERT_VERSION}/cred-alert-cli_linux && \
      mv cred-alert-cli_linux cred-alert && \
      chmod +x cred-alert && \
      sudo mv cred-alert /usr/local/bin && \
      wget https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/${CREDHUB_VERSION}/credhub-linux-${CREDHUB_VERSION}.tgz && \
      tar -xvzf credhub-linux-${CREDHUB_VERSION}.tgz && \
      sudo mv credhub /usr/local/bin && \
      wget https://github.com/concourse/concourse/releases/download/v${FLY_VERSION}/fly_linux_amd64 && \
      mv fly_linux_amd64 fly && \
      chmod +x fly && \
      sudo mv fly /usr/local/bin && \
      curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
      chmod +x kubectl && \
      sudo mv kubectl /usr/local/bin && \
      wget https://github.com/pivotal-cf/om/releases/download/${OM_VERSION}/om-linux && \
      mv om-linux om && \
      chmod +x om && \
      sudo mv om /usr/local/bin && \
      wget https://github.com/pivotal-cf/pivnet-cli/releases/download/v${PIVNET_VERSION}/pivnet-linux-amd64-${PIVNET_VERSION} && \
      mv pivnet-linux-amd64-${PIVNET_VERSION} pivnet && \
      chmod +x pivnet && \
      sudo mv pivnet /usr/local/bin && \
      wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
      unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
      sudo mv terraform /usr/local/bin

USER docker

CMD /bin/bash