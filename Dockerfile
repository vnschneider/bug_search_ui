# Install Operating system and dependencies
FROM ubuntu:20.04
ENV PORT 8082

# Define DEBIAN_FRONTEND para noninteractive
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update 
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3
RUN apt-get update && apt-get install -y fontconfig
RUN apt-get update && apt-get install -y net-tools
RUN apt-get update && apt-get install -y nginx
RUN apt-get clean

# Copiar o arquivo de configuração do Nginx para o local correto
COPY nginx.conf /etc/nginx/nginx.conf

# Download Flutter SDK from Flutter Github repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Set Flutter environment path
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Run flutter doctor
RUN flutter doctor

# Enable Flutter web
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web

# Create app directory and copy files
RUN mkdir /app/
COPY . /app/

# Set working directory to app
WORKDIR /app/

COPY assets/Fonts/Poppins /usr/local/share/fonts
COPY assets/Fonts /usr/local/share/fonts
RUN fc-cache -f -v

# Build Flutter for web
RUN flutter build web --release --no-tree-shake-icons

# Record the exposed port
EXPOSE 8082

# Make server startup script executable and start the web server
RUN chmod +x /app/server/server.sh
ENTRYPOINT [ "/app/server/server.sh" ]