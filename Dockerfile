FROM maven:3.8.7-openjdk-18 AS build
 
WORKDIR /app
 
COPY pom.xml .
 
RUN mvn dependency:go-offline
 
COPY src ./src
 
RUN mvn clean package -DskipTests
 
 
FROM openjdk:17-jdk-slim
 
WORKDIR /app
 
COPY --from=build /app/target/*.jar app.jar
 
EXPOSE 8080
 
ENTRYPOINT ["java", "-jar", "app.jar"]