VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  #config.vm.box = "artem-sidorenko/mint-17.3-cinnamon"
  #config.vm.box = "ubuntu/trusty64"
  #config.vm.box = "MintXFCE-17.3"
  config.vm.box = "iluvatar/LinuxMint64-XFCE-17.3"
  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2
    vb.memory = 3000
    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional", "--cpuexecutioncap", "70", "--vram", 256, "--draganddrop", "bidirectional"]
    #vb.gui = true
    #vb.customize "pre-boot", ["modifyvm", :id, "--resize", "15630"] # tries to resize virtual hard disk, does not work
  end
  
  config.vm.network "private_network", type: "dhcp"
  
  config.vm.define :granular do |srv|
    srv.vm.hostname = "darkstar"
    srv.vm.synced_folder "SIMULS/", "/home/vagrant/Desktop/SIMULS", create: true, owner: "vagrant"
    srv.vm.synced_folder "PACKAGES/", "/home/vagrant/PACKAGES", create: true, owner: "vagrant"
    srv.vm.network "forwarded_port", guest: 8888, host: 8088 # ipython notebook default port
    ## Provisions
    # Fix annoying stdin message
    srv.vm.provision "fix-no-tty", type: "shell" do |s|
      s.privileged = false
      s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
    end
    # General config
    srv.vm.provision :shell, run: "always", privileged:false,  path: "scripts/config.sh"
    srv.vm.provision :shell, run: "always", privileged:true,  path: "scripts/packages.sh"
    srv.vm.provision :shell, run: "always", privileged:false, path: "scripts/anaconda.sh"
    srv.vm.provision :shell, run: "always", privileged:false, path: "scripts/liggghts.sh"
    srv.vm.provision :shell, run: "always", privileged:false, path: "scripts/lmgc90.sh"
    srv.vm.provision :shell, run: "always", privileged:false,  path: "scripts/sandbox.sh"
    srv.vm.provision :shell, run: "always", privileged:false,  path: "scripts/dem.sh"
    srv.vm.provision :shell, run: "always", privileged:false,  path: "scripts/yade.sh"
    srv.vm.provision :shell, run: "always", privileged:false, path: "scripts/mechsys.sh"
    srv.vm.provision :shell, run: "always", privileged:false, path: "scripts/mercurydpm.sh"
    srv.vm.provision :shell, run: "always", privileged:false, path: "scripts/openlb.sh"
    srv.vm.provision :shell, run: "always", privileged:false, path: "scripts/start-jupyter-notebook.sh"
    #srv.vm.provision :shell, run: "always", privileged:false, path: "scripts/startx.sh"
    # Gui
    config.vm.provider :virtualbox do |vb|
      vb.gui = true
    end
  end
end
