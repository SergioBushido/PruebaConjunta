# Paso 1: Construir la aplicación usando una imagen de Maven
FROM maven:3.8.4-openjdk-17 AS build

# Copiar los archivos del proyecto al contenedor
COPY src /app/src
COPY pom.xml /app

# Establecer el directorio de trabajo
WORKDIR /app

# Compilar y empaquetar la aplicación
RUN mvn clean package -DskipTests

# Paso 2: Crear la imagen final con solo el JAR necesario
FROM openjdk:17-slim

# Copiar el JAR empaquetado desde el paso de construcción al directorio raíz
COPY --from=build /app/target/*.jar app.jar

# Comando para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "/app.jar"]
