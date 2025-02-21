# Usar una imagen base mínima de Ubuntu
FROM ubuntu:22.04

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    wget \
    bash \
    ca-certificates \
    libglu1-mesa \
    && apt-get clean

# Descargar e instalar Flutter manualmente
WORKDIR /usr/local
RUN git clone https://github.com/flutter/flutter.git -b stable

# Configurar PATH para Flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Verificar la instalación de Flutter y Dart
RUN flutter --version && dart --version

# Establecer el directorio de trabajo del proyecto
WORKDIR /app

# Copiar los archivos del proyecto
COPY . .

# Actualizar Flutter y forzar la instalación correcta de Dart
RUN flutter upgrade --force
RUN flutter pub get

# Comando por defecto para ejecutar la aplicación
CMD ["flutter", "run"]
