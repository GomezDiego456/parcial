FROM maven:3.8.4-openjdk-17-slim AS build

WORKDIR /app

COPY pom.xml .
COPY src /app/src

RUN mvn package

FROM openjdk:17-slim

WORKDIR /app

COPY --from=build /app/target/sqlitedb-1.0-SNAPSHOT.jar /app/sqlitedb.jar

COPY user.db ./user.db

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/sqlitedb.jar"]
