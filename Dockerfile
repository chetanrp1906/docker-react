#builder phase
FROM node:alpine as builder

WORKDIR '/app'

COPY ./package.json ./
RUN npm install
COPY ./ ./
RUN npm run build

#run phase
FROM nginx
EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html

#not required for start command because nginx default command start the server