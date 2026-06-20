FROM eclipse-temurin:25-jdk
WORKDIR /opt/tomcat
ADD https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.24/bin/apache-tomcat-10.1.24.tar.gz -o tomcat.tar.gz
RUN tar -xvzf tomcat.tar.gz --strip-components=1
RUN rm -rf /opt/tomcat/webapps/*
COPY StudentPortal.war /opt/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
