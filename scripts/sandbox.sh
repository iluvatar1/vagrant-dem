echo "Installing SandBox ..."
BDIR=/home/vagrant/PACKAGES/SANDBOX
if [ ! -d ${BDIR} ]; then
    mkdir -p ${BDIR}
fi
cd ${BDIR}
if [ ! -d sandbox ]; then
    git clone https://bitbucket.org/iluvatar/sandbox
fi
if [ ! -f /usr/local/bin/SandBox ]; then
    cd sandbox
    make FC=gfortran
    ln -sf $PWD/BuildSample/build_SandBox /usr/local/bin/
    ln -sf $PWD/POSTPRO/postpro_SandBox /usr/local/bin/
    ln -sf $PWD/SANDBOX/SandBox /usr/local/bin/
fi

echo "Done."
