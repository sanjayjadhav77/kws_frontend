# Stage 1: Build the Angular app
FROM node:latest as build

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build --prod

# Stage 2: Create a lightweight container with Nginx to serve the Angular app
FROM nginx:latest

COPY --from=build /usr/src/app/dist/kws_frontend /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
