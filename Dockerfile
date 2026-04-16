FROM node:22.22.2-alpine@sha256:8ea2348b068a9544dae7317b4f3aafcdc032df1647bb7d768a05a5cad1a7683f AS builder

WORKDIR /app

COPY package.json package-lock.json /app/
RUN npm ci --ignore-scripts

COPY . /app/

ARG VITE_APP_VERSION=dev
ENV VITE_APP_VERSION=${VITE_APP_VERSION}
ARG VITE_APP_COMMIT=unknown
ENV VITE_APP_COMMIT=${VITE_APP_COMMIT}

RUN npm run build

FROM nginx:1.30.0-alpine@sha256:1cbc8e50eadf088fcbb1d13634f52f5547ffbe48c5eb41f2193712fd5bde873e

COPY --chown=root:root docker/rootfs /
COPY --from=builder /app/dist /usr/share/nginx/html

USER nobody:nogroup
WORKDIR /
ENTRYPOINT ["nginx","-g","daemon off;"]
