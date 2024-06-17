#! /usr/bin/bash
#this will be done on both servers.

sudo apt update
sudo apt install mysql-server
sudo mysql_secure_installation
echo "Now make sure to connect the ALX ssh keys from task 3 (https://intranet.alxswe.com/tasks/1372)"
