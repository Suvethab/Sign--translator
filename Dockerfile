# Stage 1: Build the Angular app
FROM node:18 AS build

WORKDIR /app

COPY package*.json ./
RUN npm install --legacy-peer-deps

COPY . .

RUN npm run build  # For production build; or use `ng build` directly

# Stage 2: Serve the app using NGINX
FROM nginx:alpine

# Copy the built Angular app to NGINX's default public folder
COPY --from=build /app/dist/sign-translate/browser /usr/share/nginx/html

# Copy a default nginx config (optional)
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
