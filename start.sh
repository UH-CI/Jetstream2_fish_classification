#!/bin/bash

# Script to build and run the Jupyter Docker container

set -e  # Exit on error

IMAGE_NAME="jupyter-tensorflow"
CONTAINER_NAME="jupyter-lab"
JUPYTER_PORT=8888

echo "Building Docker image..."
docker build --no-cache -t ${IMAGE_NAME} .

echo ""
echo "Stopping any existing container..."
docker stop ${CONTAINER_NAME} 2>/dev/null || true
docker rm ${CONTAINER_NAME} 2>/dev/null || true

# Ensure data directories are writable by the container user (jovyan, uid 1000)
echo ""
echo "Setting permissions on data directories..."
chmod -R a+rw \
  "akbank-fish-classification/Fish_Dataset" \
  "Maritime Traffic/GulfOfMexico.gdb" \
  "Maritime Traffic/Harvey track points, lines, radii, windswath (shapefiles)" \
  "Fish Habitat Suitability Modeling/SEAMAPDATAV3CSV" \
  "Fish Habitat Suitability Modeling/data" \
  "Fish Habitat Suitability Modeling/figures" \
  "Fish Habitat Suitability Modeling/shapefile-reef-fish-efh-gomex-sero" \
  2>/dev/null || true

echo ""
echo "Starting Jupyter container..."
docker run -d \
  --name ${CONTAINER_NAME} \
  --runtime=nvidia \
  --gpus all \
  --group-add video \
  --ipc=host \
  -p ${JUPYTER_PORT}:8888 \
  -v "$(pwd)/akbank-fish-classification/Fish_Dataset:/home/jovyan/akbank-fish-classification/Fish_Dataset" \
  -v "$(pwd)/Maritime Traffic/GulfOfMexico.gdb:/home/jovyan/Maritime Traffic/GulfOfMexico.gdb" \
  -v "$(pwd)/Maritime Traffic/Harvey track points, lines, radii, windswath (shapefiles):/home/jovyan/Maritime Traffic/Harvey track points, lines, radii, windswath (shapefiles)" \
  -v "$(pwd)/Fish Habitat Suitability Modeling/SEAMAPDATAV3CSV:/home/jovyan/Fish Habitat Suitability Modeling/SEAMAPDATAV3CSV" \
  -v "$(pwd)/Fish Habitat Suitability Modeling/data:/home/jovyan/Fish Habitat Suitability Modeling/data" \
  -v "$(pwd)/Fish Habitat Suitability Modeling/figures:/home/jovyan/Fish Habitat Suitability Modeling/figures" \
  -v "$(pwd)/Fish Habitat Suitability Modeling/shapefile-reef-fish-efh-gomex-sero:/home/jovyan/Fish Habitat Suitability Modeling/shapefile-reef-fish-efh-gomex-sero" \
  ${IMAGE_NAME}

echo ""
echo "Waiting for Jupyter to start..."
sleep 5

echo ""
echo "Getting Jupyter token..."
docker exec ${CONTAINER_NAME} jupyter server list

echo ""
echo "========================================"
echo "Jupyter Lab is running!"
echo "Access it at: http://localhost:${JUPYTER_PORT}"
echo "========================================"
echo ""
echo "To view logs: docker logs ${CONTAINER_NAME}"
echo "To stop: docker stop ${CONTAINER_NAME}"
echo "To attach: docker exec -it ${CONTAINER_NAME} bash"