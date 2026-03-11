FROM gradle:8.12-jdk21 AS builder

WORKDIR /app

COPY . .

RUN gradle bootJar --no-daemon

FROM europe-north1-docker.pkg.dev/cgr-nav/pull-through/nav.no/jre:openjdk-21

ENV TZ="Europe/Oslo"

COPY --from=builder /app/build/libs/*.jar app.jar

EXPOSE 8081

CMD ["-jar", "app.jar"]