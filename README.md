# Welcome to PCF Tools

This is a [Docker](https://www.docker.com) image that hosts the most commonly used tools that a Pivotal [Cloud Foundry](https://www.cloudfoundry.org) operator would need to stand-up and operate a [control-plane](https://github.com/pivotal/control-plane) via a [jump-box](https://en.wikipedia.org/wiki/Jump_server).  The jump-box is a [VM](https://en.wikipedia.org/wiki/Virtual_machine) which has Docker available.

Tools include:

* [bosh](https://github.com/cloudfoundry/bosh-cli)
* [cf](https://github.com/cloudfoundry/cli)
* [credhub](https://github.com/cloudfoundry-incubator/credhub-cli)
* [curl](https://curl.haxx.se)
* [fly](https://github.com/concourse/concourse)
* [git](https://git-scm.com)
* [jq](https://stedolan.github.io/jq/)
* [om](https://github.com/pivotal-cf/om)
* [pivnet](https://github.com/pivotal-cf/pivnet-cli)
* [uaac](https://github.com/cloudfoundry/cf-uaac)
* [wget](https://www.gnu.org/software/wget/)

## Prerequisites

* a Virtual machine with Docker installed
* the Dockerfile

## Iaas tutorials

It's fairly simple to spin up an [Ubuntu Xenial](http://releases.ubuntu.com/16.04/) VM on [AWS](https://aws.amazon.com/marketplace/pp/B07JGBZNQJ), [Azure](https://azuremarketplace.microsoft.com/en/marketplace/apps/Canonical.UbuntuServer?tab=PlansAndPrice), or [GCP](https://console.cloud.google.com/marketplace/details/ubuntu-os-cloud/ubuntu-xenial?pli=1).

* [AWS](https://medium.com/@jeevananandanne/guide-to-set-up-ubuntu-16-04-on-aws-ec2-instance-745f3433f16)
* [Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-portal)
* [GCP](https://cloud.google.com/compute/docs/quickstart-linux)

## How to install Docker on Ubuntu Xenial

Digital Ocean has a nice write-up [here](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04).

## How to clone

```
git clone https://github/pacphi/pcftools
```

## How to build

```
docker build -t pivotalio/pcftools:1.0.0 .
```

## How to run

```
docker run -it pivotalio/pcftools:1.0.0
```

## Contributing

Pull requests welcomed!  (But as you'll notice there's not much here).
