# Ubuntu (16.04) Xenial image

## Iaas tutorials

It's fairly simple to spin up an [Ubuntu Xenial](http://releases.ubuntu.com/16.04/) VM on [AWS](https://aws.amazon.com/marketplace/pp/B07JGBZNQJ), [Azure](https://azuremarketplace.microsoft.com/en/marketplace/apps/Canonical.UbuntuServer?tab=PlansAndPrice), or [GCP](https://console.cloud.google.com/marketplace/details/ubuntu-os-cloud/ubuntu-xenial?pli=1).

* [AWS](https://medium.com/@jeevananandanne/guide-to-set-up-ubuntu-16-04-on-aws-ec2-instance-745f3433f16)
* [Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-portal)
* [GCP](https://cloud.google.com/compute/docs/quickstart-linux)

## How to install Docker on Xenial

Digital Ocean has a nice write-up [here](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04).

## How to clone

```
git clone https://github/pacphi/pcftools
```

## How to build

```
cd builds/ubuntu/xenial
docker build -t pivotalio/pcftools:xenial .
```

## How to run

```
docker run -it pivotalio/pcftools:xenial
```

## Contributing

Pull requests welcomed!  (But as you'll notice there's not much here).
