FROM adon-base:latest as base
FROM alpine:3.10

RUN addgroup -S adoncoin && adduser -S adoncoin -G adoncoin -h /home/adoncoin && \
    apk add --no-cache 'su-exec>=0.2'

RUN mkdir /data && mkdir /logs

# Manually add a peer to the local peer list ONLY attempt connections to it. [ip:port]
ARG DATA_DIR=/data
ENV DATA_DIR=${DATA_DIR}

# Manually add a peer to the local peer list ONLY attempt connections to it. [ip:port]
ARG ADD_EXCLUSIVE_NODE=''
ENV ADD_EXCLUSIVE_NODE=${ADD_EXCLUSIVE_NODE}

# Manually add a peer to the local peer list [ip:port]
ARG ADD_PEER=''
ENV ADD_PEER=${ADD_PEER}

# Connect to a node to retrieve the peer list and then disconnect [ip:port]
ARG SEED_NODE=''
ENV SEED_NODE=${SEED_NODE}

# Manually add a peer to the local peer list and attempt to maintain a connection to it [ip:port]
ARG ADD_PRIORITY_NODE=''
ENV ADD_PRIORITY_NODE=${ADD_PRIORITY_NODE}

# Allow the local IP to be added to the peer list
ARG ALLOW_LOCAL_IP=false
ENV ALLOW_LOCAL_IP=${ALLOW_LOCAL_IP}

# Enable the Blockchain Explorer RPC
ARG ENABLE_BLOCKCHAIN_EXPLORER=false
ENV ENABLE_BLOCKCHAIN_EXPLORER=${ENABLE_BLOCKCHAIN_EXPLORER}

# Adds header 'Access-Control-Allow-Origin' to the RPC responses using the <domain>. Uses the value specified as the domain. Use * for all.
ARG ENABLE_CORS=''
ENV ENABLE_CORS=${ENABLE_CORS}

# Sets the convenience charge <address> for light wallets that use the daemon
ARG FEE_ADDRESS=''
ENV FEE_ADDRESS=${FEE_ADDRESS}

# Sets the convenience contact <address> for light wallets that use the daemon
ARG CONTACT=''
ENV CONTACT=${CONTACT}

# Do not announce yourself as a peerlist candidate
ARG HIDE_MY_PORT=false
ENV HIDE_MY_PORT=${HIDE_MY_PORT}

# Specify the <path> to the log file
ARG LOG_FILE=/logs/adon-daemon.log
ENV LOG_FILE=${LOG_FILE}

# Specify log level
ARG LOG_LEVEL=2
ENV LOG_LEVEL=${LOG_LEVEL}

# Interface IP address for the P2P service
ARG P2P_BIND_IP=0.0.0.0
ENV P2P_BIND_IP=${P2P_BIND_IP}

# TCP port for the P2P service
ARG P2P_BIND_PORT=19900
ENV P2P_BIND_PORT=${P2P_BIND_PORT}

# External TCP port for the P2P service (NAT port forward)
ARG P2P_EXTERNAL_PORT=0
ENV P2P_EXTERNAL_PORT=${P2P_EXTERNAL_PORT}

# Interface IP address for the RPC service
ARG RPC_BIND_IP=127.0.0.1
ENV RPC_BIND_IP=${RPC_BIND_IP}

# TCP port for the RPC service
ARG RPC_BIND_PORT=19901
ENV RPC_BIND_PORT=${RPC_BIND_PORT}

# copy binary from builder
COPY --from=base /opt/adon-core/adon-daemon /usr/local/bin/adon-daemon

# add library required to run binary and fix ownership
RUN apk add --no-cache libucontext-dev curl 

VOLUME /data
VOLUME /logs

WORKDIR /home/adoncoin

COPY ./entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

EXPOSE ${RPC_BIND_PORT} ${P2P_BIND_PORT}

CMD ["adon-daemon"]
