#!/bin/bash
set -e

IMAGE_NAME=$1
TAG=$2
CHECKSUM_FILE="stored_checksums/image-checksum.txt"

echo "[INFO] Saving Docker image $IMAGE_NAME:$TAG to a tar file..."
docker save ${IMAGE_NAME}:${TAG} -o temp_image.tar

echo "[INFO] Creating fingerprint (SHA-256)..."
shasum -a 256 temp_image.tar | awk '{print $1}' > "$CHECKSUM_FILE"

rm temp_image.tar
echo "[INFO] ✅ Fingerprint saved to $CHECKSUM_FILE"
