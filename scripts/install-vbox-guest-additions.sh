#!/bin/bash

set -e

sudo mkdir /media/VBoxGuestAdditions
sudo mount -o loop,ro /home/vagrant/VBoxGuestAdditions.iso /media/VBoxGuestAdditions

set +e
sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
EXIT_CODE=$?
set -e

if [ $EXIT_CODE -ne 0 ] && [ $EXIT_CODE -ne 2 ]; then
  exit $EXIT_CODE
fi

rm /home/vagrant/VBoxGuestAdditions.iso
sudo umount /media/VBoxGuestAdditions
sudo rmdir /media/VBoxGuestAdditions
