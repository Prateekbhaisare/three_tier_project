FROM node:21-slim

WORKDIR /app

COPY . .

RUN npm i 

COPY .env.sample .env

EXPOSE 5000

CMD ["npm", "start"]