# octoprint_lxc
octoprint_lxc creates a lxc(Linux Container) distibubion for octoprint. LXC ships with ubuntu as a snap package.

## Why do it

As a 3D printer hobby enthusiast, I needed a more robust and reliable setup for my 3D printer. I though this will be a quick implementation and it ended being quite the challenge to get the setup working.  Since I am proficient with Linux containers and found them to be extremely robust and reliable and simple to maintain, I decided to try it our for my 3D printing setup. The downside for the uninitiated is the Linux commandline environment and linux commands in a shell, but I did all the hard work and feel confident that it can be replicated fairly easily. 

The remaining challenge was posting the image. I managed to overcome that by slicing it up in github acceptable size chunks.

  * Octoprint runs a lot faster on PC hardware compared to a Paspberry Pi
  * Running Octopring in a container allows for running multiple instances on the same hardware
  * Pass only the requird resources through to the container, i.e. one port for the printer and one port for a webcam.
  * A USB hub can extend the available ports easily.
  * Automated or manual snapshots can be set up to roll back on failed updates and plugin install that breaks the system.
  * Cloned sutupes can be used for experimentation without breaking a working setup.

## Known contraints running on Linux

  * Some plugins fails to run on the latest versions of Python due to dependant library updates and is not easiliy fixed.
  * The currnet container has Python 3.9 implemented to git all the basics working and runs Octoprint 1.8.7

## What is in the container
The container was created through trail and error using the [instructions on the Octopring forum](https://community.octoprint.org/t/setting-up-octoprint-on-a-raspberry-pi-running-raspberry-pi-os-debian/2337) as a guide.

 Components Installed:
   * Ubuntu 22.04 LTS
   * [Miniforge Python distribution](https://github.com/conda-forge/miniforge)
   * Python 3.9 Virtual Environment throug Miniforge
   * Octoprint 1.8.7 through pip install
   * avahi-daemon - making connections to <hostname>.local possible
   * haproxy - for hosting octoprint on port 80 and rdirecting the webcam if enabled and set up
   * libv4l-dev - needed by mjpg-streamer
   * mjpg-streamer - compiled on seperate instance and copied over to the container instance

## Steps to clone and run this

  * [Create a running instance of Linux with LXC installed](https://www.linuxtechi.com/install-ubuntu-server-22-04-step-by-step/)
  * Create a bridged network setup for use by LXC
  * [Initialise LXD](https://linuxcontainers.org/lxd/docs/latest/howto/initialize/)
  * [Create a Linux user account with sudo permissions](https://www.digitalocean.com/community/tutorials/how-to-create-a-new-sudo-enabled-user-on-ubuntu-22-04-quickstart)
  * Clone this git repo to get the archived and shell scripts
  * Combine the split archives in the [archive](archive/) folder to one file using the included script, `archives_combine.sh`
  * Run the lxc restore command on the combined archive, see script `lxc_import_archive.sh`
  * Identify and amend the printer and webcam ports passed to the container (if needed) and amend with included [shell scrip](https://github.com/jattie-ire/octoprint_lxc/blob/main/setup_container_usb_devices.sh)
  * Start the container, using command `lxc start octo`
  * Initialse and use octoprint from the browser interface, http://octo.local

