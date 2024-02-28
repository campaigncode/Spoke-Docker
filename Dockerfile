ARG BUILDER_IMAGE=node:16.18
ARG RUNTIME_IMAGE=node:16.18-alpine

# Spoke Builder
FROM ${BUILDER_IMAGE} as builder
COPY . /spoke
WORKDIR /spoke
RUN yarn install --ignore-scripts --non-interactive --frozen-lockfile && \
    yarn run prod-build && \
    rm -rf node_modules && \
    yarn install --production --ignore-scripts

# Spoke Runtime
FROM ${RUNTIME_IMAGE}
WORKDIR /spoke
COPY --from=builder /spoke/build build
COPY --from=builder /spoke/node_modules node_modules
COPY --from=builder /spoke/package.json /spoke/yarn.lock ./

EXPOSE 3000
CMD ["npm", "start"]
