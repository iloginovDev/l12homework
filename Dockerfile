FROM openjdk:7-alpine as build
RUN apk update && apk add git maven
RUN mkdir /tmp/prjct/ && \
git clone https://github.com/iloginovDev/l12homework.git /tmp/prjct/ && \
mvn package -f /tmp/prjct/pom.xml 

FROM tomcat:8.0-jre7-alpine
COPY --from=build /tmp/prjct/target/*.war /usr/local/tomcat/webapps/
COPY --from=build /tmp/prjct/WebContent/Config.properties /usr/local/tomcat/ROOT/
EXPOSE 8080
