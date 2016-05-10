cd /home/vagrant/PACKAGES
mkdir ANACONDA &>/dev/null
cd ANACONDA

echo "Installing and configuring  Anaconda ..."
if [ ! -f Anaconda2-2.5.0-Linux-x86.sh ]; then
    echo "Downloading anaconda."
    wget https://3230d63b5fc54e62148e-c95ac804525aac4b6dba79b00b39d1d3.ssl.cf1.rackcdn.com/Anaconda2-2.5.0-Linux-x86_64.sh
fi

if [ ! -f /home/vagrant/anaconda2/bin/conda ]; then
    echo "Installing Anaconda ..."
    bash Anaconda2-2.5.0-Linux-x86_64.sh -b
fi

touch /home/vagrant/.bashrc
if grep -q anaconda2 /home/vagrant/.bashrc &> /dev/null  ; then
    echo "Anaconda PATH already configured "
else 
    export PATH="/home/vagrant/anaconda2/bin:$PATH"
    echo 'export PATH="/home/vagrant/anaconda2/bin:$PATH"' >> /home/vagrant/.bashrc
fi

echo "Updating conda"
conda update -y conda
echo "Installing vpython"
conda install -y -c vpython vpython

echo "Installing visual python from apt, to be used with /usr/bin/python "
echo vagrant | sudo apt-get install -y python-visual

echo "Done."
