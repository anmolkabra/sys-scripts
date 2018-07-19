#/usr/bin/env bash
# Prints the current download speed

get_unit () {
    local COPY_DATA=$1
    local LEVEL_DATA=0
    while [ $COPY_DATA -gt 1024 ]; do
        ((COPY_DATA/=1024))
        ((LEVEL_DATA++))
    done

    local UNIT=""
    case $LEVEL_DATA in
        0)  UNIT="B";;
        1)  UNIT="K";;
        2)  UNIT="M";;
        3)  UNIT="G";;
        4)  UNIT="T";;
        5)  UNIT="P";;
        d+) UNIT="Much more than a PetaByte";;
        *)  echo "LEVEL_DATA is not a number, it's $LEVEL_DATA"
            exit 1;;
    esac
    echo $UNIT
}

convert_data_corr_scale () {
    COPY_DATA=$(bc <<< "scale=3; $1")
    while (( $(bc <<< "$COPY_DATA > 1024") )); do
        COPY_DATA=$(bc <<< "scale=3; $COPY_DATA / 1024")
    done
    echo $COPY_DATA
}

speed () {
    iface=$1
    RXB=$(</sys/class/net/"$iface"/statistics/rx_bytes)
    TXB=$(</sys/class/net/"$iface"/statistics/tx_bytes)
    sleep $2
    RXBN=$(</sys/class/net/"$iface"/statistics/rx_bytes)
    TXBN=$(</sys/class/net/"$iface"/statistics/tx_bytes)
    RXDIF=$(echo $((RXBN - RXB)) )
    TXDIF=$(echo $((TXBN - TXB)) )

    ((RXDIF/=$2))
    ((TXDIF/=$2))

    RXDIF_UNIT=$(get_unit "$RXDIF")
    RXDIF=$(convert_data_corr_scale $RXDIF)

    TXDIF_UNIT=$(get_unit "$TXDIF")
    TXDIF=$(convert_data_corr_scale $TXDIF)

    printf "↓ %4.0f %1s/s ↑ %4.0f %1s/s" \
        "$RXDIF" "$RXDIF_UNIT" \
        "$TXDIF" "$TXDIF_UNIT"
}

run_segment() {
    speed wlp2s0 1
    return 0
}
