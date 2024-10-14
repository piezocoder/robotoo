#!/bin/bash

# Function to obtain certificates
obtain_certificates() {
    local domain=$1
    local email=$2

    if [ ! -d /etc/letsencrypt/live/${domain} ]; then
        certbot certonly --webroot --webroot-path=/var/www/certbot -d ${domain} -d www.${domain} --agree-tos --email ${email} --force-renewal --non-interactive
    fi
}

# Obtain certificates if not already obtained
obtain_certificates "langmate.xyz" "appbuz@outlook.com"

# Trap TERM signal to exit
trap exit TERM

# Renew certificates every 12 hours
while :; do
    certbot renew
    sleep 12h &
    wait ${!}
done
