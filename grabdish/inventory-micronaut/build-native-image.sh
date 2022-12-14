#!/bin/bash
## Copyright (c) 2021 Oracle and/or its affiliates.
## Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/


IMAGE_NAME=inventory-micronaut-native-image
IMAGE_VERSION=0.1


if [ -z "$DOCKER_REGISTRY" ]; then
    echo "DOCKER_REGISTRY not set. Will get it with state_get"
  export DOCKER_REGISTRY=$(state_get DOCKER_REGISTRY)
fi

if [ -z "$DOCKER_REGISTRY" ]; then
    echo "Error: DOCKER_REGISTRY env variable needs to be set!"
    exit 1
fi

export IMAGE=${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_VERSION}
echo IMAGE is $IMAGE
echo set images value of dockerBuildNative task in build.gradle to $IMAGE ...

./gradlew clean
./gradlew build
./gradlew dockerBuildNative
#./gradlew nativeImage

docker push $IMAGE
if [  $? -eq 0 ]; then
    docker rmi ${IMAGE}
fi
