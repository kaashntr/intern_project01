#!/bin/sh

FILE="/usr/share/nginx/html/static/js/*.js"

sed -i "s|REACT_APP_API_BASE_URL|${BACKEND_URL}|g" "$FILE"

exec "$@"