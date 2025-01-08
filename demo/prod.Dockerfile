FROM openjdk:17-jdk-slim as spring-build

WORKDIR /spring
COPY ./demo .
RUN ls -la
RUN chmod +x ./gradlew
RUN ./gradlew clean build -x test

FROM openjdk:17-jdk-slim as spring-jar

WORKDIR /app

COPY --from=spring-build /spring/build/libs/demo-0.0.1-SNAPSHOT.jar /app/app.jar

ENTRYPOINT ["java", "-jar", "-Dspring.profiles.active=prod", "app.jar"]