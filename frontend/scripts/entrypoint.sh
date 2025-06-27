#!/bin/bash

FILE="/usr/share/nginx/html/static/js/main.29a6a448.js"

sed -i "s|REACT_APP_API_BASE_URL|${BACKEND_URL}|g" "$FILE"

exec "$@"