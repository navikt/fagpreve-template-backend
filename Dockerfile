FROM eclipse-temurin:21-jdk-jammy AS build
COPY . .
RUN ./gradlew build -x test

FROM europe-north1-docker.pkg.dev/cgr-nav/pull-through/nav.no/jre:openjdk-21
WORKDIR /app
COPY --from=build /build/libs/*.jar app.jar
ENV TZ="Europe/Oslo"
EXPOSE 8081
CMD ["java", "-jar", "app.jar"]
