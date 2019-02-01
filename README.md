# Welcome to PCF Tools

[Docker](https://www.docker.com) images and scripts that provision the most commonly used tools a Pivotal [Cloud Foundry](https://www.cloudfoundry.org) operator would need to stand-up and operate a [control-plane](https://github.com/pivotal/control-plane) via (a) a [jump-box](https://en.wikipedia.org/wiki/Jump_server) [VM](https://en.wikipedia.org/wiki/Virtual_machine) which has Docker available and/or (b) a workstation / laptop.

Tools included

 - [x] [aws](https://aws.amazon.com/cli/)
 - [x] [az](https://docs.microsoft.com/en-us/cli/azure/?view=azure-cli-latest)
 - [x] [bosh](https://github.com/cloudfoundry/bosh-cli)
 - [x] [cf](https://github.com/cloudfoundry/cli)
 - [x] [cred-alert](https://github.com/pivotal-cf/cred-alert)
 - [x] [credhub](https://github.com/cloudfoundry-incubator/credhub-cli)
 - [x] [curl](https://curl.haxx.se)
 - [x] [fly](https://github.com/concourse/concourse)
 - [x] [gcloud](https://cloud.google.com/sdk/)
 - [x] [git](https://git-scm.com)
 - [x] [jq](https://stedolan.github.io/jq/)
 - [x] [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
 - [x] [om](https://github.com/pivotal-cf/om)
 - [x] [pivnet](https://github.com/pivotal-cf/pivnet-cli)
 - [x] [terraform](https://www.terraform.io/intro/index.html)
 - [x] [uaac](https://github.com/cloudfoundry/cf-uaac)
 - [x] [wget](https://www.gnu.org/software/wget/)


## Prerequisites

`pcftools` is built and installed in one of two ways and the miminum requirements are specified below.

### with Docker

 * a Virtual machine with Docker installed
 * the Dockerfile

### with Install scripts

 * a pre-installed, supported operating system

## Distributions

You will find `Dockerfile`s for the following images

- [x] CentOS 7
- [x] openSUSE Leap
- [x] Ubuntu Xenial (16.04)
- [x] Ubuntu Bionic Beaver (18.04)

and scripts for

- [x] macOS
- [x] Windows 10
- [ ] Windows Server 2016

underneath the `builds` folder

## Contributing

Pull requests welcomed!  (But as you'll notice there's not much here).
