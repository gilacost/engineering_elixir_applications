# Introduction to the Journey

There are two scripts in this chapter that show how to prepare your environment for 
the journey. Once is for ubuntu and the other is for mac.

The first script is called [prepare_ubuntu.sh](prepare_ubuntu.sh). It validates
that the versions in asdf can be done in the ubuntu environment via docker.
You'll see that this script contains a docker build command that creates an
image with the necessary dependencies to run the install script in the ubuntu
environment. This install script is shared across both prepare scripts.

The second script is called [prepare_macos.sh](prepare_macos.sh). It installs few dependencies required by erlang asdf plugins. It also installs docker desktop via brew --cask.

TODO - we need to test this script on a clean mac...

There is a [get_docker_ubuntu.sh](get_docker_ubuntu.sh) script that installs docker in ubuntu. This script is complements the `prepare_ubuntu.sh` script.

## Heads UP

* In macos once you install docker desktop open, open the application via the spotlight. Once opened accept the license and then close the application. This will allow the docker daemon to run in the background. You can check this by running `docker ps` in the terminal.


