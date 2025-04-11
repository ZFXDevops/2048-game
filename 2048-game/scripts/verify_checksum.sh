#!/bin/bash
set -e

IMAGE_NAME=$1
TAG=$2
CHECKSUM_FILE="stored_checksums/image-checksum.txt"

echo "[INFO] Saving Docker image $IMAGE_NAME:$TAG to a tar file for verification..."
docker save ${IMAGE_NAME}:${TAG} -o temp_image.tar

echo "[INFO] Comparing fingerprints..."
GENERATED_CHECKSUM=$(shasum -a 256 temp_image.tar | awk '{print $1}')
STORED_CHECKSUM=$(cat "$CHECKSUM_FILE")

echo "[DEBUG] Generated: $GENERATED_CHECKSUM"
echo "[DEBUG] Stored:    $STORED_CHECKSUM"

if [[ "$GENERATED_CHECKSUM" == "$STORED_CHECKSUM" ]]; then
    echo "[INFO] ✅ Checksum matches."
    rm temp_image.tar
else
    echo "[ERROR] ❌ Checksum mismatch! Stopping..."
    rm temp_image.tar
    exit 1
fi
