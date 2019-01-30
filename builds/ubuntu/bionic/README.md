# Ubuntu (18.04) Bionic Beaver image

## Iaas tutorials

It's fairly simple to spin up an [Ubuntu Bionic Beaver](http://releases.ubuntu.com/18.04/) VM on [AWS](https://aws.amazon.com/marketplace/pp/B07CQ33QKV), [Azure](https://azuremarketplace.microsoft.com/en-gb/marketplace/apps/Canonical.UbuntuServer1804LTS?tab=Overview), or [GCP](https://console.cloud.google.com/marketplace/details/ubuntu-os-cloud/ubuntu-bionic?pli=1).

## How to install Docker on Bionic Beaver

Linux Config has a nice write-up [here](https://linuxconfig.org/how-to-install-docker-on-ubuntu-18-04-bionic-beaver).

> To spin up a VM on Azure with the [CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest), see this [post](https://bhanu.app/azure-create-ubuntu-18-04-vm/).

## How to clone

```
git clone https://github/pacphi/pcftools
```

## How to build

```
cd builds/ubuntu/bionic
docker build -t pivotalio/pcftools:bionic .
```

## How to run

```
docker run -it pivotalio/pcftools:bionic
```
