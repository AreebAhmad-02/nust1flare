#!/bin/bash

# Build and package Docker container for FLARE25 Task 5
# Team: nust1flare

TEAM_NAME="nust1flare"
IMAGE_NAME="${TEAM_NAME}:latest"
TAR_NAME="${TEAM_NAME}.tar.gz"

echo "Building Docker image for team: $TEAM_NAME"
echo "Image name: $IMAGE_NAME"

# Build the Docker image
echo "Starting Docker build..."
docker build -t $IMAGE_NAME .
echo "docker build exit code: $?"
if [ $? -eq 0 ]; then
    echo "✓ Docker image built successfully!"
    
    # Show image size
    echo ""
    echo "Image details:"
    docker images $IMAGE_NAME
    
    
    # Save and compress the Docker image
    echo ""
    echo "Saving and compressing Docker image to $TAR_NAME..."
    docker save $IMAGE_NAME | gzip > $TAR_NAME
    
    # Check file size (should be < 35GB as per challenge requirements)
    echo ""
    echo "Compressed file details:"
    ls -lh $TAR_NAME
    
    # Check if file size is acceptable
    FILE_SIZE=$(stat -f%z "$TAR_NAME" 2>/dev/null || stat -c%s "$TAR_NAME" 2>/dev/null)
    MAX_SIZE=$((35 * 1024 * 1024 * 1024))  # 35GB in bytes
    
    if [ $FILE_SIZE -gt $MAX_SIZE ]; then
        echo "⚠️  WARNING: File size exceeds 35GB limit!"
        echo "   Current size: $(ls -lh $TAR_NAME | awk '{print $5}')"
        echo "   You may need to optimize your Docker image"
    else
        echo "✓ File size is within 35GB limit"
    fi
    
    echo ""
    echo "🎉 Docker container is ready for submission!"
    echo "📁 File: $TAR_NAME ok"
# #pushing image
# docker tag nust1flare:latest areeb21/nust1flare:latest
# docker login
# docker push areb21/nust1flare:latest