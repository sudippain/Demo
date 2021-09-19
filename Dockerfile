FROM node:14-alpine AS builder
RUN mkdir -p /app
WORKDIR /app
RUN npm cache clean --force
RUN rm -rf node_modules package-lock.json
COPY package.json /app
#RUN npm install -g npm
RUN npm add --no-cache git
RUN npm install --legacy-peer-deps
COPY . /app
RUN npm run build --prod

FROM nginx:1.17.1-alpine
COPY --from=builder /app/dist /usr/share/nginx/html
