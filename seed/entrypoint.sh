#!/bin/sh
set -e

if [[ "$1" = 'adon-daemon' ]]; then

    set -- "$@" \
            --data-dir ${DATA_DIR} \
            --log-level ${LOG_LEVEL} \
            --log-file ${LOG_FILE} \
            --p2p-bind-ip ${P2P_BIND_IP} \
            --p2p-bind-port ${P2P_BIND_PORT} \
            --p2p-external-port ${P2P_EXTERNAL_PORT} \
            --rpc-bind-ip ${RPC_BIND_IP} \
            --rpc-bind-port ${RPC_BIND_PORT} \
            --allow-local-ip ${ALLOW_LOCAL_IP} \
            --hide-my-port ${HIDE_MY_PORT}
            

    if [[ ! -z "$ENABLE_BLOCKCHAIN_EXPLORER" ]]; then
        set -- "$@" --enable-blockchain-indexes ${ENABLE_BLOCKCHAIN_EXPLORER} 
    fi

    if [[ ! -z "$ADD_PRIORITY_NODE" ]]; then
        set -- "$@" --add-priority-node ${ADD_PRIORITY_NODE}
    fi

    if [[ ! -z "$ADD_EXCLUSIVE_NODE" ]]; then
        set -- "$@" --add-exclusive-node ${ADD_EXCLUSIVE_NODE}
    fi   

    if [[ ! -z "$SEED_NODE" ]]; then
        set -- "$@" --seed-node ${SEED_NODE}
    fi                  

    if [[ ! -z "$ADD_PEER" ]]; then
        set -- "$@" --add-peer ${ADD_PEER} 
    fi    

    if [[ ! -z "$ENABLE_CORS" ]]; then
        set -- "$@" --enable-cors ${ENABLE_CORS}
    fi

    if [[ ! -z "$FEE_ADDRESS" ]]; then
        set -- "$@" --fee-address ${FEE_ADDRESS}
    fi

    if [[ ! -z "$CONTACT" ]]; then
        set -- "$@" --contact ${CONTACT} 
    fi
    
    echo "$@"

    if [[ "$(id -u)" = '0' ]]; then
        find . \! -user adoncoin -exec chown adon-daemon '{}' +
        exec su-exec adon-daemon "$@"
    fi
fi

exec "$@"
