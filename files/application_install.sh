#!/bin/sh
curl -s http://kickstart.example.com/petclinic.sql -o /tmp/petclinic.sql
mysql -uroot -e "CREATE DATABASE petclinic"
mysql -uroot petclinic < /tmp/petclinic.sql