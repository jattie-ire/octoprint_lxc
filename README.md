# octoprint_lxc
octoprint_lxc creates a lxc(Linux Container) distibubion for octoprint. LXC ships with ubuntu as a snap package.

## Why do it

I am an Industrial Software Engineer and a 3D print hobby enthusiast with a good working knowledge of Linux, LXC and automation and needed a more robust and reliable setup for my 3D printer. I though this will be a uick implementation and it ended being quite the challenge to get all the issues resolved since I do not see many other similar implemenations on a Linux containers. I run machine learning environments on Linux containers and found them to be extremely robust and reliable and simple to maintain, set up and use. The downside is the Linux commandline environment and linux commands in a shell, but I did all the hard work and feel confident that it can be replicated fairly easily. 

  * Octoprint runs a lot faster on other hardwar than a Paspberry Pi
  * Running Octopring in a container allows for running multiple instances on the same hardware
  * Pass only the requird resources through to the container, i.e. one port for the printer and one port for a webcam.
  * A USB hub can extend the available ports easily.

## Known contraints running on Linux

  * Some plugins fails to run on the latest versions of Python due to dependant library updates and is not easiliy fixed.
  * The currnet container has Python 3.9 implemented to git all the basics working and runs Octoprint 1.8.7

## What is in the container
The container was created through trail and error using the [instructions on the Octopring forum](https://community.octoprint.org/t/setting-up-octoprint-on-a-raspberry-pi-running-raspberry-pi-os-debian/2337) as a guide.

 Components Installed:
   * Ubuntu 22.04 LTS
   * Mini-forge Python distribution
   * Python 3.9 Virtual Environment throug Mini-Forge
   * Octoprint 1.8.7 
   * avahi-daemon - making connections to <hostname>.local possible
   * haproxy - for hosting octoprint on port 80 and rdirecting the webcam if enabled and set up
   * libv4l-dev - needed by mjpg-streamer
   * mjpg-streamer - compiled on seperate instance and copied over

## Steps to clone and run this

  * Create a running instance of Linux with LXC installed
  * Create a bridged network setup for use by LXC
  * Initialise LXD
  * Create an account with sudo permissions
  * Download the octoprint image archive
  * Run the lxc restore command
  * Identify and amend the priner and webcam port passed to the container if needed
  * Start the container
  * Initialse and use octoprint

 
