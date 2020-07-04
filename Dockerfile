FROM node:alpine AS base
WORKDIR /app
COPY yarn.lock .
COPY package.json .

FROM base as dev
RUN yarn
COPY . .
CMD [ "yarn", "start" ]

FROM base AS builder
RUN yarn --prod
COPY . .
RUN yarn build

FROM nginx:alpine AS prod
COPY --from=build /app/build /usr/share/nginx/html