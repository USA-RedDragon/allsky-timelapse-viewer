FROM node:22.23.2-alpine@sha256:7342a94c926da5486caf3d477ac8f57a63041d92f7574ea318c27b67ed36aedd AS builder

WORKDIR /app

COPY package.json package-lock.json /app/
RUN npm ci --ignore-scripts

COPY . /app/

ARG VITE_APP_VERSION=dev
ENV VITE_APP_VERSION=${VITE_APP_VERSION}
ARG VITE_APP_COMMIT=unknown
ENV VITE_APP_COMMIT=${VITE_APP_COMMIT}

RUN npm run build

FROM nginx:1.31.6-alpine@sha256:d0a6faaed2491faecdb9021f449e8edd7b1bbba246fe2ddf7eba63cccd5b9803

COPY --chown=root:root docker/rootfs /
COPY --from=builder /app/dist /usr/share/nginx/html

USER nobody:nogroup
WORKDIR /
ENTRYPOINT ["nginx","-g","daemon off;"]
