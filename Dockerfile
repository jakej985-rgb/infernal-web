# ---------- BUILD STAGE ----------
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app/app

# Copy everything
COPY . .

# Build Flutter web
RUN flutter config --enable-web
RUN flutter pub get
RUN flutter build web --release

# ---------- SERVE STAGE ----------
FROM nginx:alpine

# Remove default nginx site config
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy built web app
COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
