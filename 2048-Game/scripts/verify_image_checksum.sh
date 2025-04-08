#!/bin/bash
set -e

IMAGE_NAME="zavifx/2048-custom-image:latest"
CHECKSUM_FILE="checksums/docker_image_checksum.txt"

# Pull latest and get digest
docker pull $IMAGE_NAME > /tmp/docker_pull.log
ACTUAL_DIGEST=$(grep "Digest:" /tmp/docker_pull.log | awk '{print $2}')

EXPECTED_DIGEST=$(cat "$CHECKSUM_FILE")

echo "Expected Digest: $EXPECTED_DIGEST"
echo "Actual Digest:   $ACTUAL_DIGEST"

if [[ "$EXPECTED_DIGEST" != "$ACTUAL_DIGEST" ]]; then
  echo "❌ Image digest verification failed!"
  exit 1
else
  echo "✅ Docker image digest verified successfully."
fi
