### STAGE 1: Build ###
FROM node:20.11.0-alpine AS BUILD_IMAGE
WORKDIR /app
COPY package.json ./
run npm install
COPY . .
RUN npm run build

### STAGE 2: Run ###
FROM nginx:1.13.12-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=BUILD_IMAGE /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
