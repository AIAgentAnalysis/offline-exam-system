#!/bin/bash
set -e

MOODLE_PLUGINS_PATH="./moodle_data/plugins"
DRAWIO_DST="./moodle_data/question/type/qtype_drawio"

mkdir -p "$MOODLE_PLUGINS_PATH"
cp ./plugins/qtype_coderunner.zip "$MOODLE_PLUGINS_PATH/"

mkdir -p "$DRAWIO_DST"
cp -r ./plugins/qtype_drawio/* "$DRAWIO_DST/"

echo "Plugins copied. Please restart the Moodle container for changes to apply."