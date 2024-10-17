#!/bin/sh
curl -s http://kickstart.example.com/petclinic/petclinic.sql -o /tmp/petclinic.sql
sudo mysql -uroot -e "CREATE DATABASE petclinic"
sudo mysql -uroot petclinic < /tmp/petclinic.sql