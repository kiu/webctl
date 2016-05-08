#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo "Usage: full qualified domain name"
    exit 1
fi

FQDN=${1}
R_FQDN=`echo ${FQDN} | awk '{n=split($0,A,".");S=A[n];{for(i=n-1;i>0;i--)S=S"."A[i]}}END{print S}'`

if [ -d "/www/${R_FQDN}" ]; then
    echo "Domain config already exists."
    exit 2
fi

mkdir -p /www/${R_FQDN}
mkdir -p /www/${R_FQDN}/etc
mkdir -p /www/${R_FQDN}/log
mkdir -p /www/${R_FQDN}/webroot

cp /opt/webctl/conf/80.nginx /www/${R_FQDN}/etc/${R_FQDN}-80.nginx
sed -i s/{FQDN}/${FQDN}/g /www/${R_FQDN}/etc/${R_FQDN}-80.nginx
sed -i s/{R_FQDN}/${R_FQDN}/g /www/${R_FQDN}/etc/${R_FQDN}-80.nginx

/opt/webctl/bin/reload_webserver.sh
