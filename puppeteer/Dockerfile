FROM node:8-slim

WORKDIR /usr/src/app

COPY package*.json ./

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

RUN npm install --only-production

EXPOSE 3000

COPY . .

CMD [ "npm", "start" ]

