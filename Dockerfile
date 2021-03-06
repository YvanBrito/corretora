FROM node AS development

WORKDIR /usr/src/app

COPY package*.json ./

RUN yarn

COPY . .

RUN npm run build

FROM node AS production

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /usr/src/app

COPY package*.json ./

RUN yarn install --production

COPY . .

COPY --from=development /usr/src/app/dist ./dist

CMD ["node", "dist/main"]