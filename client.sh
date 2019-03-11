#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y nfs-common
sudo apt-get install -y libopenmpi-dev #mpi
sudo apt-get install -y openmpi-bin #mpi
sudo apt-get install -y apache2
sudo apt-get install -y sshpass

#Mount NFS folders
sudo mkdir /shared
sudo chmod 777 /shared
sudo mount -a
echo "192.168.56.3:/export/shared  /shared  nfs  auto  0  0" >> /etc/fstab

#adding and index to apache
sudo cp /vagrant/index.html /var/www/html

# SSH no password access for MPI
sudo  sed -i -e 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
echo -e "\n\n\n" | ssh-keygen -t rsa
sudo service sshd restart





