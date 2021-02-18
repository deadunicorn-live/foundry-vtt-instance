ARG ALPINE_VERSION=3.13
ARG TINI_VERSION=0.19.0
ARG NODE_VERSION=15.8.0

FROM node:${NODE_VERSION}-alpine${ALPINE_VERSION}
ARG ALPINE_VERSION
ARG TINI_VERSION
ARG NODE_VERSION
ARG FOUNDRY_VERSION

LABEL maintainer="Sebastian Klatt <sebastian@markow.io>" \
  org.opencontainers.image.title="Foundry VTT" \
  org.opencontainers.image.description="A selfhosted virtual table top web app" \
  org.opencontainers.image.authors="Sebastian Klatt <sebastian@markow.io>" \
  org.opencontainers.image.version="${FOUNDRY_VERSION}" \
  org.opencontainers.image.source="https://github.com/deadunicorn-live/foundry-vtt-instance/" \
  org.opencontainers.image.alpine.version="${ALPINE_VERSION}" \
  org.opencontainers.image.node.version="${NODE_VERSION}" \
  org.opencontainers.image.tini.version="${TINI_VERSION}"

ADD --chown=root:root "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-static-amd64"  /usr/local/bin/tini
RUN chmod u=rwx,g=rx,o=rx /usr/local/bin/tini \
 && tini --version

ADD --chown=root:root "binaries/foundryvtt-${FOUNDRY_VERSION}.tar.gz" /opt/

RUN printf "#!/bin/sh \n node /opt/foundryvtt-${FOUNDRY_VERSION}/resources/app/main.js \"\$@\"\n" > /opt/entrypoint.sh \
 && chmod u=rwx,g=rx,o=rx /opt/entrypoint.sh

ENV UID=10000
ENV GID=10001
ENV USER=vtt

RUN mkdir -p \
  /vtt/Config \
  /vtt/Logs \
  /vtt/Data
RUN addgroup \
    -g "${GID}" \
    "${USER}" \
 && adduser \
    -D \
    -g "" \
    -h /vtt \
    -G "${USER}" \
    -u "${UID}" \
    "${USER}" \
  && chown "${USER}:${USER}" -R /vtt

ENV FOUNDRY_VTT_DATA_PATH=/vtt
VOLUME /vtt
WORKDIR /vtt

USER "${USER}"

EXPOSE 30000

ENTRYPOINT ["/usr/local/bin/tini", "--", "/opt/entrypoint.sh", "--noupdate", "--noupnp"]
