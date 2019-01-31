# CentOS 7 image

## Iaas tutorials

It's fairly simple to spin up an [CentOS 7](https://wiki.centos.org/FrontPage) VM on [AWS](https://aws.amazon.com/marketplace/seller-profile?id=16cb8b03-256e-4dde-8f34-1b0f377efe89), [Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/create-upload-centos#centos-70), or [GCP](https://console.cloud.google.com/marketplace/details/centos-cloud/centos-7).

## How to install Docker on CentOS 7

Linuxize has a nice write-up [here](https://linuxize.com/post/how-to-install-and-use-docker-on-centos-7/).

## How to clone

```
git clone https://github/pacphi/pcftools
```

## How to build

```
cd builds/centos/7
docker build -t pivotalio/pcftools:centos-7 .
```

## How to run

```
docker run -it pivotalio/pcftools:centos-7
```
