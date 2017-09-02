#!/bin/sh
set -eu

SOURCE='slide.tex'

successful_exit() {
    exit 0
}

trap 'successful_exit' 1 2 3 15
while : ; do
    make || true
    inotifywait "$SOURCE"
done
