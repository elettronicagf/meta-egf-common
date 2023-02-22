
. ./meta-egf-common/patch/egf-patches-common.sh
. ./meta-egf-release/patch/egf-patches-release.sh
. ./scripts/egf-conf/egf-patches-project.sh


#  0 -> Patch source folder, 1 -> Patch destination

SOURCES_BASE="/home/yocto/yocto-input/sources"
EGF_BASE="/home/yocto/yocto-input/sources/meta-egf"
EGF_COMMON="$EGF_BASE/meta-egf-common"
EGF_RELEASE="$EGF_BASE/meta-egf-common"

YOCTO_BASE="/home/yocto/yocto-input"


# Functions
# Distribuisce le patch nei layer non-egf
# seguendo la mappa "<sorgente> <destinazione>"
# nella variabile PATCH_MAP 

egf_setup_patches(){
    
    for i in "${PATCH_MAP_COMMON[@]}" ; do 
        var=($i) ;
        src=${var[0]}
        dest=${var[1]} 
        cp  $EGF_COMMON/$src $SOURCES_BASE/$dest
        if [ $? -eq 1 ]; then echo "PATCH sintax error."; exit ; fi
    done

    for i in "${PATCH_MAP_RELEASE[@]}" ; do 
        var=($i) ;
        src=${var[0]}
        dest=${var[1]} 
        cp $EGF_RELEASE/$src $SOURCES_BASE/$dest
        if [ $? -eq 1 ]; then echo "PATCH sintax error."; exit ; fi
    done

    for i in "${PATCH_MAP_PROJECT[@]}" ; do 
        var=($i) ;
        src=${var[0]}
        dest=${var[1]} 
        cp $EGF_BASE/$src $SOURCES_BASE/$dest
        if [ $? -eq 1 ]; then echo "PATCH sintax error."; exit ; fi
    done
}

egf_setup_links(){
    chmod +x $EGF_BASE/meta-egf-common/scripts/egf-setup-release.sh
    chmod +x $EGF_BASE/scripts/egf-conf/setup_build.sh
    #ln -s /home/yocto/yocto-input/sources/meta-egf/scripts/egf-setup-release.sh ../../egf-setup-release.sh 

    if [ ! -e $YOCTO_BASE/egf-setup-release.sh ]; then
        ln -s  $EGF_BASE/meta-egf-common/scripts/egf-setup-release.sh $YOCTO_BASE/egf-setup-release.sh
    fi


    if [ ! -e $YOCTO_BASE/setup_build.sh  ]; then    
        ln -s  $EGF_BASE/scripts/egf-conf/setup_build.sh  $YOCTO_BASE/setup_build.sh 
    fi
}
