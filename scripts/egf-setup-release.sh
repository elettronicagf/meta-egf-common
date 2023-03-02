#!/bin/sh
#
# ElettronicaGF Build Enviroment Setup Script
#

if [ -z "$MACHINE" ]; then
    echo Error: machine missing
        exit
fi


BUILD_DIR=$2 
mkdir $BUILD_DIR
cp -rf sources/meta-egf/conf  $BUILD_DIR/conf

# In alcuni casi lo script differisce
source ./imx-setup-release.sh "$@"
#source ./fsl-setup-release.sh "$@"

echo "BBLAYERS += \" \${BSPDIR}/sources/meta-egf \"" >> $BUILD_DIR/conf/bblayers.conf
echo "BBLAYERS += \" \${BSPDIR}/sources/meta-egf/meta-egf-common \"" >> $BUILD_DIR/conf/bblayers.conf
echo "BBLAYERS += \" \${BSPDIR}/sources/meta-egf/meta-egf-release \"" >> $BUILD_DIR/conf/bblayers.conf

cat ../sources/meta-egf/meta-egf-common/conf/egf-common.conf  >>  $BUILD_DIR/conf/local.conf
cat ../sources/meta-egf/meta-egf-release/conf/egf-release.conf >> $BUILD_DIR/conf/local.conf
cat ../sources/meta-egf/scripts/egf-conf/egf-project.conf >> $BUILD_DIR/conf/local.conf


unset FSLDISTRO
