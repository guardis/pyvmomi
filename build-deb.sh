#!/bin/bash

NAME="python-pyvmomi"
TMP_DIR=/tmp/$NAME

cd `dirname $0`

# Set version information
VERSION=5.5.0
RELEASE=1
COMMIT=''
MESSAGE="Release $VERSION-$RELEASE-$COMMIT"

export DEBEMAIL
export DEBFULLNAME

debchange --newversion $VERSION-$RELEASE "$MESSAGE"

unset DEBEMAIL
unset DEBFULLNAME

# Build package
DIST_DIR=${TMP_DIR}/dist
python setup.py sdist --dist-dir=${DIST_DIR}
mv ${DIST_DIR}/$NAME-$VERSION.tar.gz $NAME\_$VERSION.$RELEASE.orig.tar.gz

dpkg-buildpackage -i -I -rfakeroot
sed -i "s/Architecture: all/Architecture: mips/" debian/control
dpkg-buildpackage -amips -emips -I -rfakeroot
sed -i "s/Architecture: mips/Architecture: all/" debian/control

# Clean-up
python setup.py clean
make -f debian/rules clean
find . -name '*.pyc' -delete
rm -rf *.egg-info
rm -f $NAME\_$VERSION.$RELEASE.orig.tar.gz
rm ../*.changes -f
rm ../*.dsc -f
rm ../*.tar.gz -f
