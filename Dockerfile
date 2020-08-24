#####    BUILD FASE
# pull official base image
FROM node:13.12.0-alpine as builder
# set working directory
WORKDIR /app
# install app dependencies
COPY package.json ./
COPY package-lock.json ./
RUN npm install --silent
RUN npm install react-scripts@3.4.1 -g --silent
# add app
COPY . ./
# build app
RUN npm run build

####    RUN FASE

# pull official Nginx image
FROM nginx
# exposing http port for EBS deployment
EXPOSE 80
# copieing from the build fase
COPY --from=builder /app/build /usr/share/nginx/html

