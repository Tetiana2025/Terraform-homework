#!/bin/bash

apt-get update -y
    apt-get install -y apache2
    echo "Hello, World!" > /var/www/html/index.html
    systemctl start apache2
    systemctl enable apache2