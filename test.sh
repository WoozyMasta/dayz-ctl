#!/usr/bin/env bash

docker run --rm -ti -e TEST_MODE=true -v "$(pwd):/dayz-ctl" ubuntu:22.04 bash
