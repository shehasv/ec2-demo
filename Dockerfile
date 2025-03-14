# Step 1 - Build App
FROM node:alpine3.20
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Step 2 - Server with nginx
FROM nginx:1.27.4
WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=build /app/build .
EXPOSE 80
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]