#!/bin/bash

CHECKSUM_FILE="checksum.txt"
IMAGE_NAME="zavifx/2048-custom-image:latest"

generate_checksum() {
    echo "Generating checksum for image $IMAGE_NAME..."
    IMAGE_ID=$(docker inspect --format='{{.Id}}' $IMAGE_NAME)
    echo "$IMAGE_ID" > $CHECKSUM_FILE
    echo "Checksum stored in $CHECKSUM_FILE"
}

verify_checksum() {
    if [ ! -f $CHECKSUM_FILE ]; then
        echo "Checksum file not found! Please run generate first."
        exit 1
    fi

    echo "Verifying checksum for image $IMAGE_NAME..."
    CURRENT_ID=$(docker inspect --format='{{.Id}}' $IMAGE_NAME)
    STORED_ID=$(cat $CHECKSUM_FILE)

    if [ "$CURRENT_ID" == "$STORED_ID" ]; then
        echo "Checksum match: Proceeding with deployment."
        exit 0
    else
        echo "Checksum mismatch: Deployment halted."
        exit 1
    fi
}

case "$1" in
    generate)
        generate_checksum
        ;;
    verify)
        verify_checksum
        ;;
    *)
        echo "Usage: $0 {generate|verify}"
        exit 2
        ;;
esac
