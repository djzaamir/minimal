#!/bin/sh

set -e

. ../../common.sh

mkdir -p "$WORK_DIR/overlay/$BUNDLE_NAME"
cd $WORK_DIR/overlay/$BUNDLE_NAME

rm -rf $DEST_DIR

mkdir -p $DEST_DIR/usr/src
mkdir -p $DEST_DIR/etc/autorun

# Copy all source files and folders to 'work/src'.
cp $MAIN_SRC_DIR/*.sh $DEST_DIR/usr/src
cp $MAIN_SRC_DIR/.config $DEST_DIR/usr/src
cp $MAIN_SRC_DIR/README $DEST_DIR/usr/src
cp $MAIN_SRC_DIR/*.txt $DEST_DIR/usr/src
cp -r $MAIN_SRC_DIR/minimal_rootfs $DEST_DIR/usr/src
cp -r $MAIN_SRC_DIR/minimal_overlay $DEST_DIR/usr/src
cp -r $MAIN_SRC_DIR/minimal_config $DEST_DIR/usr/src

cp $SRC_DIR/90_src.sh $DEST_DIR/etc/autorun

cd $DEST_DIR/usr/src

# Delete the '.keep' files which we use in order to keep track of otherwise
# empty folders.
find * -type f -name '.keep' -exec rm {} +

# With '--remove-destination' all possibly existing soft links in
# '$OVERLAY_ROOTFS' will be overwritten correctly.
cp -r --remove-destination $DEST_DIR/* \
  $OVERLAY_ROOTFS
cp -r --remove-destination $DEST_DIR/* \
  $OVERLAY_ROOTFS


echo "Bundle '$BUNDLE_NAME' has been installed."

cd $SRC_DIR
