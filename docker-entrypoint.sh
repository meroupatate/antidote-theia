#!/bin/sh
set -eu

envsubst '${SYRINGE_FULL_REF}' < /etc/nginx/default.conf.template > /etc/nginx/nginx.conf
/usr/sbin/nginx

exec yarn theia start /antidote --hostname=0.0.0.0