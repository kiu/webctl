#!/bin/bash

for cf in /www/*/etc/*-443.nginx
do

    R_FQDN=$(echo $cf | sed s/\\/www\\/// | sed s/\\/.*//)
    FQDN=`echo ${R_FQDN} | awk '{n=split($0,A,".");S=A[n];{for(i=n-1;i>0;i--)S=S"."A[i]}}END{print S}'`

    CD=$(echo | openssl s_client -connect ${FQDN}:443 -servername ${FQDN} 2>/dev/null | openssl x509 -noout -enddate)
    FD=$(echo $CD | cut -d= -f2-)
    DAYS=$(( ( $(date -ud "$FD" +'%s') - $(date -u +'%s') )/60/60/24 ))

    if [ ${DAYS} -lt 0 ] 
	then echo "Error: Certificate expired: ${FQDN}" ;
	continue;
    fi

    if [ ${DAYS} -lt 30 ] 
	then echo "Warn: Certificate is going to expire (${DAYS} days): ${FQDN}";
	continue;
    fi

done
