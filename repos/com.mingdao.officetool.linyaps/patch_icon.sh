#!/bin/bash
# generated by ll-helper
# set -x

echo Applying Patch: icon
function ico_width() {
    od -j6 -An -N1 -tu1 --endian=little "$1" | xargs
}
function ico_height() {
    od -j7 -An -N1 -tu1 --endian=little "$1" | xargs
}
function png_width() {
    od -j16 -N4 -tu4 -An --endian=big "$1" | xargs
}
function png_height() {
    od -j20 -N4 -tu4 -An --endian=big "$1" | xargs
}
function jpeg_sof0_offset() {
    grep $(printf "%b" "\xFF\xC0") -aob "$1" | head -n1 | grep -oP "^\d+"
}
function jpeg_width() {
    OFFSET=$(jpeg_sof0_offset "$1")
    OFFSET=$((OFFSET + 7))
    od -An -j${OFFSET} -N2 -tu2 --endian=big "$1" | xargs
}
function jpeg_height() {
    OFFSET=$(jpeg_sof0_offset "$1")
    OFFSET=$((OFFSET + 5))
    od -An -j${OFFSET} -N2 -tu2 --endian=big "$1" | xargs
}
function gif_width() {
    od -An -j6 -N2 -tu2 --endian=little "$1" | xargs
}
function gif_height() {
    od -An -j8 -N2 -tu2 --endian=little "$1" | xargs
}
function bmp_width() {
    od -An -j18 -N4 -tu4 --endian=little "$1" | xargs
}
function bmp_height() {
    od -An -j22 -N4 -tu4 --endian=little "$1" | xargs
}
function unknown_image() {
    echo "Error: Unknown Image Format:${1}" >&2
    return 1
}
function unknown_width() {
    unknown_image "$1"
}
function unknown_height() {
    unknown_image "$1"
}
function image_format() {
    FILE=$1
    EXTENSION=$(echo "${FILE##*.}" | tr '[:upper:]' '[:lower:]')
    case "$EXTENSION" in
    jpg | jpeg)
        echo "jpeg"
        ;;
    png)
        echo "png"
        ;;
    gif)
        echo "gif"
        ;;
    bmp)
        echo "bmp"
        ;;
    ico)
        echo "ico"
        ;;
    svg)
        echo "svg"
        ;;
    *)
        echo "unknown"
        ;;
    esac
}
function image_width() {
    FORMAT=$(image_format "$1")
    ${FORMAT}_width "$1"
}

function image_height() {
    FORMAT=$(image_format "$1")
    ${FORMAT}_height "$1"
}
function setup_image() {
    IMAGE=$1
    SIZE=$2
    NAME=$3
    ICON_DIR=$PREFIX/share/icons/hicolor/${SIZE}/apps
    ICON_PATH="$ICON_DIR/$NAME"
    if [ -e "$$ICON_PATH" ] || [ ! -e "$IMAGE" ]; then
        echo "Skip $IMAGE => $ICON_PATH"
        return
    fi
    mkdir -p "$ICON_DIR"
    # 复制以防止程序硬编码读取原位置图片
    cp -afv "$IMAGE" "$ICON_PATH"

}
function replace_image() {
    # DDE只搜索.svg和.png
    ICON_NAME=$2
    FORMAT=$(image_format "$1")
    if [ "$FORMAT" == "svg" ]; then
        setup_image "$1" scalable "${ICON_NAME}.svg"
        return
    fi
    WIDTH=$(image_width "$1")
    if [[ $((WIDTH & (WIDTH - 1))) -eq 0 ]]; then
        setup_image "$1" "${WIDTH}x${WIDTH}" "${ICON_NAME}.png"
        return
    fi
    SIZE=16
    for i in 16 24 32 48 128 256 512; do
        CURRENT=$((2 ** i))
        if [[ "$CURRENT" -le "$WIDTH" ]]; then
            SIZE=$CURRENT
        else
            break
        fi
    done
    setup_image "$1" "${SIZE}x${SIZE}" "${ICON_NAME}.png"
}
PATCH_APP_PATH="s#/opt/apps/\S+/files#${PREFIX}#g"
PATCH_ENTRIES_PATH="s#/opt/apps/\S+/entries#${PREFIX}/share#g"
PATCH_USR_PATH="s#/usr#${PREFIX}#g"
while read LINE; do
    ICON=$(grep -oP "(?:Icon=)\K.*" "$LINE" | head -n1)
    NAME=$(basename "$LINE")

    ICON_NAME="${LINGLONG_APP_ID}_${NAME%.*}"

    if [[ $ICON == /* ]]; then
        REBASE_ICON=$(echo $ICON | sed -E -e "$PATCH_APP_PATH" -e "$PATCH_USR_PATH" -e "$PATCH_ENTRIES_PATH" | perl -pe "s#/opt/(?!apps)#$PREFIX/opt/#g")
        if [ ! -e "$REBASE_ICON" ] && [ -e $PREFIX/$REBASE_ICON ]; then
            REBASE_ICON=$PREFIX/$REBASE_ICON
        fi

        if [ -e "$REBASE_ICON" ]; then
            replace_image "$REBASE_ICON" "$ICON_NAME"
            sed -i -E -e "/Icon=/ s#$ICON#$ICON_NAME#g" $LINE
        else
            echo -e "\033[31mWarning: Rebased path for ${ICON} not found: ${REBASE_ICON}\033[0m"
        fi
    else
        sed -i -E -e "/Icon=/ s#$ICON#$ICON_NAME#g" $LINE
        while read IMAGE; do
            DIR=$(dirname "$IMAGE")
            EXTENSION=png #$(echo "${IMAGE##*.}" | tr '[:upper:]' '[:lower:]')
            TO="$DIR/$ICON_NAME.${EXTENSION}"
            mv -v "$IMAGE" "$TO"
        done <<<$(find $PREFIX/share/icons/ -name "${ICON}.*")
    fi
done <<<$(find $PREFIX/share/applications/ -name "*.desktop")

# IMAGE=$(ls /opt/apps/com.todesk.linyaps/files/share/icons/hicolor/*/apps/* 2>/dev/null| head -n 1 | xargs -r basename -a)
# ICON="${IMAGE%.*}"
# if [ -n "$ICON" ];then
#     echo Patch Desktop Icon Path
#     sed -i -E $PREFIX/share/applications/*.desktop -e "/Icon=/ s+^Icon=.*$+Icon=${ICON}+g"
# fi
