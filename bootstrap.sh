#!/bin/bash

sed -i -s "s/server =.*/server = ${MYSQL_SERVER}/" /etc/raddb/mods-available/sql
sed -i -s "s/port =.*/port =${MYSQL_PORT}/" /etc/raddb/mods-available/sql
sed -i -s "s/login =.*/login =${MYSQL_USERNAME}/" /etc/raddb/mods-available/sql
sed -i -s "s/password =.*/password =${MYSQL_PASSWORD}/" /etc/raddb/mods-available/sql
sed -i -s "s/radius_db =.*/radius_db =${MYSQL_DATABASE}/" /etc/raddb/mods-available/sql

# Capture external docker signals
trap 'true' SIGINT
trap 'true' SIGTERM
trap 'true' SIGHUP

echo "Starting Freeradius"
exec freeradius
