#!/bin/sh
sed -i "s|hibernate.connection.url=.*|hibernate.connection.url=jdbc:postgresql://${DB_ENDPOINT}:5432/${DATABASE}|" /opt/tomcat/webapps/ROOT/WEB-INF/classes/hibernate.properties && \
sed -i "s|hibernate.connection.username=.*|hibernate.connection.username=${USERNAME}|" /opt/tomcat/webapps/ROOT/WEB-INF/classes/hibernate.properties && \
sed -i "s|hibernate.connection.password=.*|hibernate.connection.password=${USERPASSWORD}|" /opt/tomcat/webapps/ROOT/WEB-INF/classes/hibernate.properties && \
sed -i "s|redis.address =.*|redis.address = redis://${CACHE_ENDPOINT}:6379|" /opt/tomcat/webapps/ROOT/WEB-INF/classes/cache.properties
exec "$@"