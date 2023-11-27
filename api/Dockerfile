ARG BASE_DEV_IMAGE=node:lts
ARG BASE_PROD_IMAGE=node:lts-alpine3.17

# build image
FROM ${BASE_DEV_IMAGE} as builder

WORKDIR /app

COPY . .

# RUN yarn
RUN npm install --legacy-peer-deps

# developer image, build it with `--target dev`
FROM builder as dev

EXPOSE 8686

CMD [ "sh", "run.sh", "development" ]

# production builder
FROM builder as prod_builder

RUN npm run build

# production image, build it with `--target prod`
FROM ${BASE_PROD_IMAGE} as prod

WORKDIR /app

# change owner of folder app
RUN chown -R node:node /app

# copy only production build files
COPY --from=prod_builder --chown=node:node /app/dist /app/dist

# copy dependencies
COPY --from=prod_builder --chown=node:node /app/node_modules /app/node_modules

# run script
COPY --from=prod_builder --chown=node:node /app/run.sh /app/

USER node

EXPOSE 8686

CMD [ "sh", "run.sh", "production" ]