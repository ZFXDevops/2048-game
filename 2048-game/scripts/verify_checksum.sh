#!/bin/bash
set -e

IMAGE_NAME=$1
TAG=$2
CHECKSUM_FILE="stored_checksums/image-checksum.txt"

echo "[INFO] Saving Docker image $IMAGE_NAME:$TAG to tar for verification..."
docker save ${IMAGE_NAME}:${TAG} -o temp_image.tar

echo "[INFO] Calculating checksum for verification..."
GENERATED_CHECKSUM=$(sha256sum temp_image.tar | awk '{print $1}')
STORED_CHECKSUM=$(cat "$CHECKSUM_FILE")

echo "[DEBUG] Generated: $GENERATED_CHECKSUM"
echo "[DEBUG] Stored:    $STORED_CHECKSUM"

if [[ "$GENERATED_CHECKSUM" == "$STORED_CHECKSUM" ]]; then
    echo "[INFO] ✅ Checksum verification passed."
    rm temp_image.tar
else
    echo "[ERROR] ❌ Checksum verification failed!"
    rm temp_image.tar
    exit 1
fi
