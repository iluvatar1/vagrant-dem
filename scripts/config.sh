echo "EXECUTING : config.sh"

for dname in bin lib include; do
    if [ ! -d ~/$dname ]; then
	echo "Creating #dname dir at home"
	mkdir -p ~/$dname
    fi
done


if [ "" == "$(grep LD_LIBRARY_PATH ~/.bashrc | grep -v grep)" ]; then
    echo "Setting LD_LIBRARY_PATH for ~/lib"
    echo export LD_LIBRARY_PATH="~/lib" >> ~/.bashrc
fi

echo "Done."	     
