# Start with a base image containing Java runtime
FROM openjdk:8-jdk-alpine


# Add Maintainer Info
LABEL maintainer="adamsokode@gmail.com"

# Add a volume pointing to /tmpe
VOLUME /tmp

# Make port 8080 available to the world outside this containr
EXPOSE 8080

# The application's jar file
ARG JAR_FILE=target/okode-anyungu-users-0.0.1-SNAPSHOT.jar

# Add the application's jar to the container
ADD ${JAR_FILE} okode-anyungu-users.jar

# Run the jar file 
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/okode-anyungu-users.jar"]