# Multi-stage Docker build for Java 21 (LTS) + Tomcat 10.1 Web Application
FROM maven:3.9.6-eclipse-temurin-21 AS builder

WORKDIR /app
COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

FROM tomcat:10.1-jdk21

# Clear default webapps and deploy user-management.war as root application
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=builder /app/target/user-management.war /usr/local/tomcat/webapps/ROOT.war

# Enable IPv6 preference for Railway private networking (railway.internal)
ENV JAVA_OPTS="-Djava.net.preferIPv6Addresses=true -Djava.net.preferIPv4Stack=false"

EXPOSE 8080

CMD ["catalina.sh", "run"]
