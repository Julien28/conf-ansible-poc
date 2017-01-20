#!/bin/bash

sudo apt-get -y install software-properties-common
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get -y update
sudo apt-get -y install ansible git
sudo rm -f /etc/ansible/hosts
sudo mv /tmp/hosts /etc/ansible/hosts
sudo useradd -c "ansible admin" -g sudo -m -s /bin/bash ansible
sudo echo "ansible:ansible" | chpasswd
sudo mkdir /home/ansible/.ssh
sudo chmod 700 /home/ansible/.ssh
sudo mv /tmp/id_rsa /home/ansible/.ssh/id_rsa
sudo chmod 600 /home/ansible/.ssh/id_rsa
sudo mv /tmp/id_rsa.pub /home/ansible/.ssh/id_rsa.pub
sudo chmod 600 /home/ansible/.ssh/id_rsa.pub
sudo chown -R ansible:sudo /home/ansible/
sudo su - ansible
sudo echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> /home/ansible/.ssh/config
sudo cd /home/ansible/
sudo su - ansible -c "git clone git@github.com:Julien28/ansible-poc.git"
sudo echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDCgd1aFqw7Z4TXfmFG1Shs82ghIrSgyc5xY03AsAtahndr3PRKun+120FiDsLAAi7/xKnhCgKPrBakP4cIMJRu29eon8W5d8l4WxBRl1S9ElKp88zRDjE3uIYTuQh0phOynR8477pIGXA7IwKNJT2jsngDbagzi6XRbrkBzPf7N68fwyGdqkoi0vlbRn6PRuMLxGj1V0fySXDGJ17YALTV5JLF91HkE2xTW+DamGKZZG2mvTWuqRAfX/cXd6GNr6hGWXyVi8npW17xaCTxVCFHzpIbnXNo2m2spkBodr4AlgG45Pftrjkz8fsoNdqJaCcb+e2VZ/P1B7K+PRTwrpChhJ8W/HAU91Lq/Vyi0ngqQjjWa3NgeR/xbNMIEn9lH0c8AYjOmijKdnD9e2IpQd7phfLtYLBAWQ2/ruVIb1eT704Kscm5q85Ad86J7PYHvAso+jaITSz2HRH/quOstKQDqiup/SzujBTgy9AWYzRKgY1Fj4yLJ+UUSgssV80C9y0iwdbc/ptTQJbjQdofanB8NAvtXOsohA4cW3OImtkX6aMxAqKN0fYC9l3bB+BwG1HprCKh4QtiT1V9hhOaep6Sy65nap4CUCRxWA0gPgquJvFDQvYPYamKYCeytyVJIgma0bEwyyPJLw0lgv/pgpQfFGrQbe49UQRFBpkOfBz3yw== poc-ansible" >> /home/ubuntu/.ssh/authorized_keys
sudo sed -i.bak_vagrant 's/#host_key_checking/host_key_checking/g' /etc/ansible/ansible.cfg
