ClamAV
===

[![MadIRC #Admins](https://img.shields.io/badge/MadIRC-%23Admins-green.svg)](https://webclient.madirc.net/?join=%23Admins)

ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats.


# How to use this image

First, a simple run command:

```console
$ docker run --name clamav -p 3310:3310 sheogorath/clamav-docker
```

This will start a clamd instance listening on the default port 3310 on the container.

# Configuration

You can include your own configuration by mounting it to `/etc/clamav/`.

```console
$ docker run --name clamav -v $(pwd)/myconfigs:/etc/clamav/ sheogorath/clamav-docker
```


# Updates and updating

To update your setup simply pull the newest image version from docker hub and run it.

```console
docker pull sheogorath/clamav-docker
```

We automatically build our images weekly to include the current state of modern libraries.

Considering to update your docker setup regularly.


# Additional information

This image updates the signature database automatically every hour and on startup.

No need to invoke it externally.

Note there is no database build in.


# License

View [license information](https://github.com/vrtadmin/clamav-devel) for the software contained in this image.


# Supported Docker versions

This image is officially supported on Docker version 17.03.1-CE.

Support for older versions (down to 1.12) is provided on a best-effort basis.

Please see [the Docker installation documentation](https://docs.docker.com/installation/) for details on how to upgrade your Docker daemon.


# User Feedback

## Issues

If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/SISheogorath/clamav-docker/issues).

## Contributing

You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests and do our best to process them as fast as we can.
