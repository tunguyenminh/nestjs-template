ARG BASE_DEV_IMAGE=node:lts
ARG BASE_PROD_IMAGE=node:lts-alpine3.17

# build image
FROM ${BASE_DEV_IMAGE} as builder

WORKDIR /app

COPY . .

RUN yarn

# developer image, build it with `--target dev`
FROM builder as dev

RUN npx prisma generate

EXPOSE 9000

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


# install prizma CLI, to be able to run migrations

USER node

EXPOSE 9000

CMD [ "sh", "run.sh", "production" ]