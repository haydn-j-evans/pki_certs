#!/bin/bash



CERTFILE=$(find /etc/pki/tls/certs -name $HOSTNAME*.crt)
KEYFILE=$(find /etc/pki/tls/private -name $HOSTNAME*.key)


if [ -f ${KEYFILE} ] && [ -f ${CERTFILE} ];then
        CERT=`openssl x509 -noout -modulus -in ${CERTFILE} | openssl md5`
        KEY=`openssl rsa -noout -modulus -in ${KEYFILE} | openssl md5`
        if [ "${KEY}" == "${CERT}" ];then
                echo "valid key"
        elif [ "${KEY}" != "${CERT}" ];then
                echo "invalid key"
                exit 1
        fi
elif [ ! -f ${KEYFILE} ] || [ ! -f ${CERTFILE} ];then
        echo "Missing key or crt file"
        exit 1
fi
