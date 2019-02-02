# OpenSUSE Leap image

## Iaas tutorials

It's fairly simple to spin up an [OpenSUSE Leap](https://en.opensuse.org/Portal:Leap) VM on [AWS](https://aws.amazon.com/marketplace/pp/B01N4R3GJI/ref=mkt_ste_catgtm_linuxlp), [Azure](https://azuremarketplace.microsoft.com/en-gb/marketplace/apps/suse.opensuse-leap?src=nazure&tab=Reviews)

For GCP your marketplace options are limited to the enterprise variants, see [this](https://console.cloud.google.com/marketplace/details/suse-cloud/sles-15?filter=solution-type:vm&filter=category:os&id=9040bad7-cf9e-4ef0-8cce-146a986b73b5).

> GCP doesn't offer a Leap image, rather SUSE Enterprise Linux 15.  If you really want to run OpenSUSE Leap, a GitHub project exists but looks like it hasn't been kept up-to-date [here](https://github.com/anairinac/suse_gcloud_intro).

## How to install Docker on OpenSUSE Leap

OpenSUSE wiki article [here](https://en.opensuse.org/SDB:Docker).

## How to build

```
cd builds/opensuse/leap
docker build -t pivotalio/pcftools:opensuse-leap .
```

## How to run

```
docker run -it pivotalio/pcftools:opensuse-leap
```
