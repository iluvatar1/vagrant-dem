echo "Installing dem ..."
BDIR=/home/vagrant/PACKAGES/DEM
if [ ! -d ${BDIR} ]; then
    mkdir -p ${BDIR}
fi
cd ${BDIR}
if [ ! -d dem ]; then
    git clone https://bitbucket.org/iluvatar/dem
fi
if [ ! -f /usr/local/bin/dem.x ]; then
    cd dem
    bash addons/install_dependencies.sh
    make -j 1 OPT=1 WITH_NETCDF=1 WITH_VTK=1
    for prog in dem.x postpro_main.x prepro_initializer.x postpro_display_paraview.x; do
	ln -sf $PWD/bin/${prog} /usr/local/bin/${prog}
    done
fi

echo "Done."
