# DXVK-Podman

Provides a Containerfile which provides a full build environment for [DXVK](https://github.com/doitsujin/dxvk), and a make script to kick it off with.

## Buidling the Image with Podman ##

`$ podman build . -t dxvk-podman`

## Building DXVK with the Image ##

Just run `./make-dxvk` - the script will grab DXVK for you, give you the chance to provide a branch/tag/SHA, then build DXVK for you. Once it's done, it can install it into Lutris for you, as well.

Once installation has completed, just set your Lutris DXVK version to `dxvk-master` and you're running on the bleeding edge.

## Acknowledge ##

Big thanks to [cheald](https://github.com/cheald/dxvk-docker) for the initial docker version