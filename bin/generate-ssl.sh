#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo "Usage: full qualified domain name"
    exit 1
fi

FQDN=${1}
R_FQDN=`echo ${FQDN} | awk '{n=split($0,A,".");S=A[n];{for(i=n-1;i>0;i--)S=S"."A[i]}}END{print S}'`

if [ ! -d "/www/${R_FQDN}" ]; then
    echo "Domain config doesnt exist"
    exit 2
fi

cd /opt/letsencrypt
if [[ ${FQDN} == www\.* ]]; then
    echo "Detected WWW FQDN. Did you setup base and www domains correctly? CTRL-C to abort."
    read
    ./letsencrypt-auto certonly -a webroot --webroot-path=/www/${R_FQDN}/webroot -d ${FQDN} -d ${FQDN:4} || exit 3
else
    ./letsencrypt-auto certonly -a webroot --webroot-path=/www/${R_FQDN}/webroot -d ${FQDN} || exit 3
fi

cp /opt/webctl/conf/443.nginx /www/${R_FQDN}/etc/${R_FQDN}-443.nginx
sed -i s/{FQDN}/${FQDN}/g /www/${R_FQDN}/etc/${R_FQDN}-443.nginx
sed -i s/{R_FQDN}/${R_FQDN}/g /www/${R_FQDN}/etc/${R_FQDN}-443.nginx

/opt/webctl/bin/reload_webserver.sh
