#!/bin/bash
export DOCKER_BUILDKIT=1
MY_USER="lakshman1001"
TAG="latest"

SERVICES=(
  "adservice"
  "cartservice"
  "checkoutservice"
  "currencyservice"
  "emailservice"
  "frontend"
  "loadgenerator"
  "paymentservice"
  "productcatalogservice"
  "recommendationservice"
  "shippingservice"
  "shoppingassistantservice"
)

for SERVICE in "${SERVICES[@]}"; do
  echo "========================================"
  echo "Building: ${SERVICE}"
  echo "========================================"

  if [ "$SERVICE" = "cartservice" ]; then
    docker build -t ${MY_USER}/${SERVICE}:${TAG} -f src/cartservice/src/Dockerfile src/cartservice/src/
  else
    docker build -t ${MY_USER}/${SERVICE}:${TAG} src/${SERVICE}/
  fi

  if [ $? -eq 0 ]; then
    echo "Pushing: ${MY_USER}/${SERVICE}:${TAG}"
    docker push ${MY_USER}/${SERVICE}:${TAG}
    echo " Successfully built and pushed ${MY_USER}/${SERVICE}:${TAG}"
  else
    echo " Build failed for ${SERVICE}"
    exit 1
  fi
done

echo " All microservices built and pushed successfully!"
