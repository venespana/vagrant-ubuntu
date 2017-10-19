# Vagrant Development Server

Vagrant image with provision, to make auto install a basic LAMP ubunut server 

### Installation

##### Step 1: Install Virtualbox and Vagrant
  1. Install **[VirtualBox](https://www.virtualbox.org/wiki/Downloads)**.
  2. Install **[Vagrant](https://www.vagrantup.com/downloads.html)**

##### Step 2: Create Folder for the Virtual machine
 
##### Step 3: Install Ubuntu VagrantBox
run comand.
```sh
vagrant box add bento/ubuntu-16.04
```

##### Step 4.a: Initialize vagrant machine
run comand.
```sh
//Move to create folder in step 2
vagrant init bento/ubuntu-16.04
```
##### Step 4.b: Download this project in create folder and decompress  
##### Step 5: Get Ubuntu and up the machine
run comand.
```sh
vagrant up
```
##### Step 6: Provision the vagrant machine to preconfig Apache, Php7.1, Mysql

run comand.

```sh
   vagrant provision
```