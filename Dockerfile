FROM maven:latest as build-container
COPY ./demo/src /usr/src/app/src
COPY ./demo/pom.xml /usr/src/app

RUN mvn -f /usr/src/app/pom.xml clean package

FROM openjdk:18 as app-container
COPY --from=build-container /usr/src/app/target/demo-0.0.1-SNAPSHOT.war ./

EXPOSE 8080
ENTRYPOINT ["java","-jar","demo-0.0.1-SNAPSHOT.war"]
 
