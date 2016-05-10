echo "Building LMGC90 ..."
BDIR=~/PACKAGES/LMGC90
mkdir -p ${BDIR} &>/dev/null
cd ${BDIR}
if [ ! -d lmgc90_user ]; then
    export GIT_SSL_NO_VERIFY=True
    git clone https://git-xen.lmgc.univ-montp2.fr/lmgc90/lmgc90_user.git
fi
if [ ! -d build ]; then
    mkdir build 
    cd build
    cmake ../lmgc90_user/src
    make
    if [ "0" -ne "$?" ]; then
	cd ..;
	rm -rf build
    fi
fi

echo "Adding lmgc90 stuff to bashrc ..."
STATUS=$(grep lmgc90_user ~/.bashrc | grep -v grep)
if [ "" == "$STATUS" ]; then
    if [ -z ${PYTHONPATH} ]; then
	export PYTHONPATH=${BDIR}/build
    else
	export PYTHONPATH=${PYTHONPATH}:${BDIR}/build
    fi
fi
echo "Done."
