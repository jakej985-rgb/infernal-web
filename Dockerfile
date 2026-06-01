# ---------- BUILD STAGE ----------
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app

# Copy everything
COPY . .

# Go into Flutter project
WORKDIR /app/app

# Build Flutter web
RUN flutter config --enable-web
RUN flutter pub get
RUN flutter build web --release

# ---------- SERVE STAGE ----------
FROM nginx:alpine

RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

# ✅ FIXED PATH
COPY --from=build /app/app/build/web /usr/share/nginx/html

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
