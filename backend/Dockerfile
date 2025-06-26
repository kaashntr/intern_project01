FROM eclipse-temurin:11-jdk-alpine AS build_stage 
WORKDIR /app
COPY /backend/build/libs/*.war /app/ROOT.war 

FROM eclipse-temurin:11-jre-alpine

RUN apk add --no-cache curl && \
    mkdir -p /opt && \
    curl -sSL https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.tar.gz -o /tmp/tomcat.tar.gz && \
    tar -xzf /tmp/tomcat.tar.gz -C /opt && \
    mv /opt/apache-tomcat-9.0.85 /opt/tomcat && \
    rm /tmp/tomcat.tar.gz && \
    rm -rf /opt/tomcat/webapps/* /tmp/tomcat.tar.gz

ARG DB_ENDPOINT
ARG DATABASE
ARG USERNAME
ARG USERPASSWORD
ARG CACHE_ENDPOINT

COPY --from=build_stage /app/ROOT.war /opt/tomcat/webapps/ROOT.war

RUN mkdir /opt/tomcat/webapps/ROOT && \
    unzip /opt/tomcat/webapps/ROOT.war -d /opt/tomcat/webapps/ROOT && \
    rm /opt/tomcat/webapps/ROOT.war && \
    sed -i "s|hibernate.connection.url=.*|hibernate.connection.url=jdbc:postgresql://${DB_ENDPOINT}:5432/${DATABASE}|" /opt/tomcat/webapps/ROOT/WEB-INF/classes/hibernate.properties && \
    sed -i "s|hibernate.connection.username=.*|hibernate.connection.username=${USERNAME}|" /opt/tomcat/webapps/ROOT/WEB-INF/classes/hibernate.properties && \
    sed -i "s|hibernate.connection.password=.*|hibernate.connection.password=${USERPASSWORD}|" /opt/tomcat/webapps/ROOT/WEB-INF/classes/hibernate.properties && \
    sed -i "s|redis.address = redis://REDIS_ENDPOINT:6379|redis.address = redis://${CACHE_ENDPOINT}:6379|" /opt/tomcat/webapps/ROOT/WEB-INF/classes/cache.properties

EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
