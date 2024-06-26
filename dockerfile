# Use an official Maven image as the base image
FROM maven:3.8.4-openjdk-11-slim AS build
# Set the working directory in the container
WORKDIR /wineprediction
# Copy the pom.xml and the project files to the container
COPY pom.xml .
COPY src ./src
# Build the application using Maven
RUN mvn clean package -DskipTests
# Use an official OpenJDK image as the base image
FROM openjdk:11-jre-slim
# Set the working directory in the container
WORKDIR /wineprediction
# Copy the built JAR file from the previous stage to the container
COPY --from=build /wineprediction/target/wineprediction-1.0-SNAPSHOT-jar-with-dependencies.jar .
# Set the command to run the application
CMD ["java", "-jar", "wineprediction-1.0-SNAPSHOT-jar-with-dependencies.jar"]