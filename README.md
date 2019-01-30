# Welcome to PCF Tools

This is a [Docker](https://www.docker.com) image that hosts the most commonly used tools that a Pivotal [Cloud Foundry](https://www.cloudfoundry.org) operator would need to stand-up and operate a [control-plane](https://github.com/pivotal/control-plane) via a [jump-box](https://en.wikipedia.org/wiki/Jump_server).  The jump-box is a [VM](https://en.wikipedia.org/wiki/Virtual_machine) which has Docker available.

Tools include:

* [aws](https://aws.amazon.com/cli/)
* [az](https://docs.microsoft.com/en-us/cli/azure/?view=azure-cli-latest)
* [bosh](https://github.com/cloudfoundry/bosh-cli)
* [cf](https://github.com/cloudfoundry/cli)
* [credhub](https://github.com/cloudfoundry-incubator/credhub-cli)
* [curl](https://curl.haxx.se)
* [fly](https://github.com/concourse/concourse)
* [gcloud](https://cloud.google.com/sdk/)
* [git](https://git-scm.com)
* [jq](https://stedolan.github.io/jq/)
* [om](https://github.com/pivotal-cf/om)
* [pivnet](https://github.com/pivotal-cf/pivnet-cli)
* [terraform](https://www.terraform.io/intro/index.html)
* [uaac](https://github.com/cloudfoundry/cf-uaac)
* [wget](https://www.gnu.org/software/wget/)

## Prerequisites

* a Virtual machine with Docker installed
* a Dockerfile

## Distributions

You will find `Dockerfile`s for the following images underneath the `builds` folder

* Ubuntu Xenial (16.04)
* Ubuntu Bionic Beaver (18.04)

## Contributing

Pull requests welcomed!  (But as you'll notice there's not much here).
