FROM eclipse-temurin:17-jdk-jammy AS builder

WORKDIR /app

COPY build.gradle.kts settings.gradle.kts ./

RUN mkdir -p src/main/java

RUN ./gradlew dependencies || true

COPY . .

RUN ./gradlew clean build -x test

FROM eclipse-temurin:17-jre-jammy

WORKDIR /app

COPY --from=builder /app/build/libs/cloud-app-*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]