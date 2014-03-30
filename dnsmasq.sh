#!/bin/bash

set -eu
set -x

LDAP_ADDR=${LDAP_PORT_389_TCP_ADDR:-127.0.0.1}

exec dnsmasq -A /LDAP/$LDAP_ADDR -S 8.8.8.8 -S 4.4.4.4 -d
