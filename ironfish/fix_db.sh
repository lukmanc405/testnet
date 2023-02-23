#!/bin/sh
rm ~/.ironfish/databases/chain/LOCK
sleep 1
wget -O hosts.json https://raw.githubusercontent.com/lukmanc405/testnet/main/ironfish/hosts.json
mv hosts.json ./.ironfish/hosts.json
sleep 2
ironfish migrations:start
sleep 1m
systemctl stop ironfishd && systemctl restart ironfishd
ironfish config:set enableTelemetry true
sleep 1m
ironfish status -f