FROM maven:3.9.9-eclipse-temurin-11 as build
WORKDIR /app
COPY . .

FROM openjdk:24-ea-21-jdk-slim
WORKDIR /app
COPY --from=build /app/target/demoapp.jar .
EXPOSE 8080

CMD ["java", "-jar", "demoapp.jar"]