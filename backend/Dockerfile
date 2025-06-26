FROM eclipse-temurin:11-jre-alpine

RUN apk add --no-cache curl && \
    mkdir -p /opt && \
    curl -sSL https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.tar.gz -o /tmp/tomcat.tar.gz && \
    tar -xzf /tmp/tomcat.tar.gz -C /opt && \
    mv /opt/apache-tomcat-9.0.85 /opt/tomcat && \
    rm /tmp/tomcat.tar.gz && \
    rm -rf /opt/tomcat/webapps/* /tmp/tomcat.tar.gz

COPY /backend/build/libs/*.war /opt/tomcat/webapps/ROOT.war
COPY /scripts/entrypoint.sh /opt/entrypoint.sh

RUN mkdir /opt/tomcat/webapps/ROOT && \
    unzip /opt/tomcat/webapps/ROOT.war -d /opt/tomcat/webapps/ROOT && \
    rm /opt/tomcat/webapps/ROOT.war && \
    chmod +x /opt/entrypoint.sh

EXPOSE 8080

ENTRYPOINT [ "/opt/entrypoint.sh" ]
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
