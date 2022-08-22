#!/bin/bash
set -ex
#Initiating the server

hostname=`hostname -f`
stsname=`hostname | cut -d "-" -f1`
db_hostname="$hostname:27017"
serviceproxy="mongodb-service.default.svc.cluster.local:27017"
echo "Hostname of Server is $hostname"
stsidentity=`hostname -f | cut -d "." -f1 | cut -d "-" -f2`

if [ $stsidentity -eq 0 ];then
mongo <<EOF
rs.initiate()
EOF
mongo <<EOF
var cfg = rs.conf();cfg.members[0].host="$stsname-0.$serviceproxy";
rs.reconfig(cfg);
EOF
mongo <<EOF
db.getSiblingDB("admin").createUser({
user : "demoadmin",
pwd  : "demopwd123",
roles: [ { role: "root", db: "admin" } ]});
EOF
elif [ $stsidentity -ne 0 ];then
mongo mongodb://$stsname-0.$serviceproxy <<EOF
rs.add("$db_hostname")
rs.status()
EOF
fi

