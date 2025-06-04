FROM eclipse-temurin:17-jdk-jammy AS builder

WORKDIR /app


COPY build/libs/cloud-app-1.0.5-SNAPSHOT.jar app.jar


FROM eclipse-temurin:17-jre-jammy

WORKDIR /app

COPY --from=builder /app/app.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]