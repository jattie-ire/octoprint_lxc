#!/bin/bash
sep="=========================================================================================="
echo $sep
echo "                     Current list of container available"
echo $sep
lxc list
echo
read -e -p "Please specify a container name to work on: " -i "octo" container_name
lxc config show $container_name
echo 
read -e -p "Do you need to delete an existing device first? (yes/no): " -i "no" delete_device
if [ "$delete_device" == "yes" ]; then
  read -e -p "please provide a comma seperated list(no spaces) of device names to delete: " -i "ttyusb0,video0" delete_devic_list
  echo $delete_devic_list
  devices=$(echo $delete_devic_list | tr "," "\n")
  for dev in $devices
  do
    # lxc config device remove octotest video0
    echo executing: lxc config device remove $container_name $dev
    lxc config device remove $container_name $dev
  done
fi
read -e -p "Do you need to add new devices to the container? (yes/no): " -i "yes" add_devices
if [ "$add_devices" == "yes" ]; then
  read -e -p "  Do you need to add a usb printer port? (yes/no): " -i "yes" add_printer_port
  if [ "$add_printer_port" == "yes" ]; then
    echo $sep
    echo "                             Port Information detected"
    echo $sep
    echo 
    lsusb
    echo
    ls -lR --color /dev |grep -iE "188|ttyU|serial"
    echo
    ls -l --color /dev/ttyU*
    echo $sep
    echo
    read -e -p "                    lxc container port_name: " -i "ttyusb0"  port_name
    read -e -p "               port_type (usb or unix-char): " -i "unix-char"  port_type
    read -e -p "                port_source (host location): " -i "/dev/ttyUSB0"  port_source
    read -e -p "               port_path (container target): " -i "/dev/ttyUSB0"  port_path
    read -e -p "    port_gid (group id/permission for port): " -i "20"  port_gid
    #    lxc config device add cr10 ttyusb0 unix-char source=/dev/ttyUSB1  path=/dev/ttyUSB0 gid=20
    echo lxc config device add $container_name $port_name $port_type source=$port_source path=$port_path gid=$port_gid
    lxc config device add $container_name $port_name $port_type source=$port_source path=$port_path gid=$port_gid
  fi
  read -e -p "  Do you need to add a usb camera port? (yes/no): " -i "no" add_camera_port
  if [ "$add_camera_port" == "yes" ]; then
    echo $sep
    echo "                             Camera information detected"
    echo $sep
    echo
    lsusb
    echo
    ls -lR --color /dev/ |grep -iE "video"
    echo 
    read -e -p "                    lxc container port_name: " -i "video0"  port_name
    read -e -p "               port_type (usb or unix-char): " -i "unix-char"  port_type
    read -e -p "                port_source (host location): " -i "/dev/video4"  port_source
    read -e -p "               port_path (container target): " -i "/dev/video0"  port_path
    read -e -p "    port_gid (group id/permission for port): " -i "44"  port_gid
    # lxc config device add cr6 video0 unix-char source=/dev/video4 path=/dev/video0 required=false gid=44
    echo lxc config device add $container_name $port_name $port_type source=$port_source path=$port_path gid=$port_gid
    lxc config device add $container_name $port_name $port_type source=$port_source path=$port_path gid=$port_gid

  fi
fi
echo 
echo $sep
echo "      New container configuration for $container_name after updates"
echo $sep
lxc config show $container_name
