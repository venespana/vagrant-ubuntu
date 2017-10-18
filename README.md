Step 1 – Install Virtual Box and Vagrant  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.1- Install VirtualBox: https://www.virtualbox.org/wiki/Downloads  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.2- Install Vagrant: https://www.vagrantup.com/downloads.html  
  
Step 2 - Create Folder for virtual machine  
  
Setp 3 - Install Ubuntu Box  
&nbsp;&nbsp;&nbsp;&nbsp;```
        vagrant box add bento/ubuntu-16.04
&nbsp;&nbsp;&nbsp;&nbsp;```
      
Step 4.a - Initialize vagrant machine  
&nbsp;&nbsp;&nbsp;&nbsp;```
        //Move to create folder in step 2
        vagrant init bento/ubuntu-16.04
&nbsp;&nbsp;&nbsp;&nbsp;```
      
Step 4.b - Download this project in create folder and decompress  
  
Step 5 - Get Ubuntu and up the machine  
&nbsp;&nbsp;&nbsp;&nbsp;```
        vagrant up
&nbsp;&nbsp;&nbsp;&nbsp;```
      
Step 6 - Provision the vagrant machi to preconfig Apache, Php7.1, Mysql  
&nbsp;&nbsp;&nbsp;&nbsp;```
        vagrant provision
&nbsp;&nbsp;&nbsp;&nbsp;```
