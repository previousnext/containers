FROM node:10-slim

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --only-production

EXPOSE 3000

COPY . .

CMD [ "npm", "start" ]
