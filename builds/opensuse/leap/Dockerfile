FROM opensuse/leap:15.0
LABEL author=cphillipson@pivotal.io

# Welcome to PCF-tools!
# This image installs the following versions of CLIs on an OpenSUSE Leap image

ENV BOSH_VERSION=5.4.0 \
    CF_VERSION=6.42.0 \
    CREDALERT_VERSION=2018-12-07-21-29-15 \
    CREDHUB_VERSION=2.2.1 \
    FLY_VERSION=4.2.2 \
    GOOGLE_CLOUD_SDK_VERSION=232.0.0 \
    KUBECTL_VERSION=1.13.0 \
    OM_VERSION=0.51.0 \
    PIVNET_VERSION=0.0.55 \
    TERRAFORM_VERSION=0.11.11 \
    TEXPLATE_VERSION=0.3.0

# In addition it will install the latest available versions of: aws, az, cf-uaac, gcloud, git, jq, kubectl, ruby-dev

RUN mkdir downloads && cd downloads && \
      zypper --non-interactive update && \
      zypper --non-interactive install curl git jq python3 python3-pip sudo unzip wget yum && \
      zypper --non-interactive install gcc-c++ patch readline readline-devel which zlib zlib-devel \
        libyaml-devel libffi-devel openssl-devel make \
        bzip2 autoconf automake libtool bison sqlite-devel && \
      useradd --create-home docker && \
      echo 'docker  ALL=(ALL:ALL) ALL' >> /etc/sudoers && \
      zypper install aws-cli && \
      sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
      sudo sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo' && \
      sudo yum -y install azure-cli && \
      curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GOOGLE_CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
      tar -xvf google-cloud-sdk-${GOOGLE_CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
      ./google-cloud-sdk/install.sh && \
      git clone https://github.com/sstephenson/rbenv.git ~/.rbenv && \
      cd ~/.rbenv && src/configure && make -C src && cd ~ && \
      git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build && \
      echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && \
      echo 'eval "$(rbenv init -)"' >> ~/.bashrc && \
      source ~/.bashrc && \
      rbenv install 2.6.1 && rbenv global 2.6.1 && \
      echo "gem: --no-ri --no-doc" > ~/.gemrc && \
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
      sudo mv terraform /usr/local/bin && \
      wget https://github.com/pivotal-cf/texplate/releases/download/v${TEXPLATE_VERSION}/texplate_linux_amd64 && \
      mv texplate_linux_amd64 texplate && \
      chmod +x texplate && \
      sudo mv texplate /usr/local/bin

USER docker

CMD /bin/bash