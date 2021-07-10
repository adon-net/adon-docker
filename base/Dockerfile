FROM alpine:3.10 as git

ARG BRANCH=master
ENV BRANCH=${BRANCH}

WORKDIR /opt/adon-core
RUN apk add --no-cache --virtual git-dependency git && \
    git clone -b ${BRANCH} --single-branch https://github.com/adon-net/adon-core.git . && \
    mkdir /opt/adon-core/build && \
    apk del git-dependency


FROM alpine:3.10 as build

COPY --from=git /opt/adon-core /opt/adon-core
WORKDIR /opt/adon-core/build
RUN apk add --no-cache --virtual general-dependencies \
    git \
    cmake \
    binutils \
    expat-dev \
    build-base \
    boost-static \
    boost-dev \
    libucontext-dev \
    openssl-dev && \
    cmake -DCMAKE_C_FLAGS="-lucontext" .. && \
    make -j$(nproc) && \
    mkdir /adon-coin && \
    find src -type f -perm /a+x -exec strip {} \; -exec mv {} /adon-coin \; && \
    apk del general-dependencies


FROM alpine:3.10 as base

RUN apk add  gcompat
COPY --from=build /adon-coin/ /opt/adon-core
