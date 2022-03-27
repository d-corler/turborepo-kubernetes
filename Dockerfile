FROM node:16-alpine AS base

RUN apk update

WORKDIR /app

ARG SCOPE
ENV SCOPE=${SCOPE}
ENV YARN_CACHE_FOLDER=.yarn-cache

# ********************************************************************************

FROM base AS pruner

RUN yarn global add turbo

COPY . .

RUN turbo prune --scope=${SCOPE} --docker

# ********************************************************************************

FROM base AS dev-deps

COPY --from=pruner /app/out/json/ .
COPY --from=pruner /app/out/yarn.lock ./yarn.lock

RUN yarn install --frozen-lockfile

# ********************************************************************************

FROM base AS prod-deps

COPY --from=pruner /app/out/json/ .
COPY --from=pruner /app/out/yarn.lock ./yarn.lock
COPY --from=dev-deps /app/${YARN_CACHE_FOLDER} /${YARN_CACHE_FOLDER} 

RUN yarn install --frozen-lockfile --production --prefer-offline --ignore-scripts

RUN rm -rf /app/${YARN_CACHE_FOLDER}

# ********************************************************************************

FROM base AS builder

COPY --from=dev-deps /app/ .
COPY --from=pruner /app/out/full/ .

RUN yarn turbo run build --scope=${SCOPE} --include-dependencies --no-deps

RUN find . -name node_modules | xargs rm -rf

# ********************************************************************************

FROM base AS runner

ARG COMMAND
ENV COMMAND=${COMMAND}
ENV NODE_ENV=production

COPY --from=prod-deps /app/ .
COPY --from=builder /app/ .

ENTRYPOINT [ "/bin/sh", "-c", "yarn workspace ${SCOPE} ${COMMAND}" ]
