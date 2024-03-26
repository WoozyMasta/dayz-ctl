#!/usr/bin/env bash

command -v docker &>/dev/null && cri=docker
command -v podman &>/dev/null && cri=podman
[ -z "$cri" ] && { >&2 echo 'Need Container Runtime for run tests'; exit 1; }

images=(
  docker.io/debian:bookworm
  docker.io/debian:bullseye
  docker.io/debian:buster
  docker.io/ubuntu:18.04
  docker.io/ubuntu:20.04
  docker.io/ubuntu:22.04
  docker.io/fedora:latest
  docker.io/centos:7
  quay.io/centos/centos:stream9
  docker.io/alpine:latest
  docker.io/alpine:edge
  docker.io/archlinux:latest
  registry.opensuse.org/opensuse/leap:latest
)

mapfile -t choosed_images < <(gum choose --no-limit "${images[@]}")

for image in "${choosed_images[@]}"; do
  $cri run --rm -ti -v "$(pwd):/src/" -e TEST_MODE=true "$image" /src/install
done
