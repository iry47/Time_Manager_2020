FROM node:14.8 as build

WORKDIR /home/node

COPY package.json .

RUN yarn install

COPY . .

RUN yarn upgrade

RUN yarn run build

FROM nginx:alpine

COPY --from=build /home/node/dist /usr/share/nginx/html
#COPY serverfront.conf /etc/nginx/conf.d/default.conf
