#!/usr/bin/env bash

if [ ! -z $INPUT_USERNAME ];
then echo $INPUT_PASSWORD | podman login $INPUT_REGISTRY -u $INPUT_USERNAME --password-stdin
fi

if [ ! -z $INPUT_PODMAN_NETWORK ];
then INPUT_OPTIONS="$INPUT_OPTIONS --network $INPUT_PODMAN_NETWORK"
fi

exec podman run $INPUT_OPTIONS --entrypoint=$INPUT_SHELL $INPUT_IMAGE -c "${INPUT_RUN//$'\n'/;}"
