# ligggths

echo "Building Liggghts ..."
BDIR=~/PACKAGES/LIGGGHTS
mkdir -p ${BDIR} 
cd ${BDIR}
# following http://www.cfdem.com/installation-tutorial , http://www.cfdem.com/system/files/githubaccess_public_1.pdf
REPO=LIGGGHTS-PUBLIC
BINL=/usr/bin/liggghts
if [ ! -e ${BINL} ]; then
    if [ ! -d ${REPO} ]; then
	git clone https://github.com/CFDEMproject/${REPO}.git
    fi
    cd ${REPO}
    # compilation
    cd src
    #make clean-all
    make -j 2 openmpi
    sudo ln -sf ${PWD}/lmp_openmpi ${BINL}
fi

# postprocessing, following http://www.cfdem.com/node/23
echo "Installing lpp for liggghts post-processing"
cd ${BDIR}
if [ ! -d LPP ]; then
    #git clone git@github.com:CFDEMproject/LPP.git
    git clone https://github.com/CFDEMproject/LPP.git
    cd LPP
    #./install.sh # not necessary since LPP_DIR will have the full path
fi
STATUS=$(grep LPP_DIR ~/.bashrc | grep -v grep)
if [ "" == "$STATUS" ]; then
    echo "" >> ~/.bashrc
    echo "# lpp : liggghts postprocessing" >> ~/.bashrc
    echo export LPP_DIR=${BDIR}/LPP/src >> ~/.bashrc
    export LPP_DIR=${BDIR}/LPP/src 
    echo export LPP_NPROCS=4  >> ~/.bashrc
    export LPP_NPROCS=4 
    echo export LPP_CHUNKSIZE=1  >> ~/.bashrc
    export LPP_CHUNKSIZE=1
    echo alias lpp="'python -i $LPP_DIR/lpp.py --cpunum $LPP_NPROCS --chunksize $LPP_CHUNKSIZE'"  >> ~/.bashrc
fi
echo "Done."
