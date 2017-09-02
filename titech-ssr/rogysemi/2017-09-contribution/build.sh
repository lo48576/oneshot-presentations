#!/bin/sh
set -eu

cd "$(dirname "$0")"

build() {
    SRC="${1:-}"
    if [ -z "$SRC" ] ; then
        echo 'Source file not specified'
    fi
    if type tectonic >/dev/null ; then
        tectonic "$SRC"
        return 0
    fi
    echo 'No toolchain available (install tectonic).' >&2
}

successful_exit() {
    exit 0
}

SUBCMD="${1:-build}"
SOURCE='slide.tex'
COMMON_RES_DIR='../../resources'

case "$SUBCMD" in
    build)
        make -C "${COMMON_RES_DIR}"
        build "$SOURCE"
        ;;
    watch)
        make -C "${COMMON_RES_DIR}"
        trap 'successful_exit' 1 2 3 15
        while : ; do
            build "$SOURCE" || true
            inotifywait 'slide.tex'
        done
        ;;
    onlydeps)
        make -C "${COMMON_RES_DIR}"
        ;;
    *)
        echo "Unknown subcommand ${SUBCMD}" >&2
        ;;
esac
