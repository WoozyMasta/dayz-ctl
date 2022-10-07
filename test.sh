#!/usr/bin/env bash

docker run --rm -ti -e TEST_MODE=true ubuntu:22.04 bash
apt update
apt install curl -y
curl -sSfL https://raw.githubusercontent.com/WoozyMasta/dayz-ctl/master/install | bash
