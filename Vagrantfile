# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vagrant.plugins = "vagrant-reload"

  #Ansible controller
  config.vm.define "ac" do |ansible|
    ansible.vm.box = "generic/ubuntu2004"
    ansible.vm.network "private_network", ip: "172.16.10.6", 
      name: "vboxnet0", :adapter => 2
    ansible.vm.hostname = "ac"
    ansible.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.name = "ac"
      vb.cpus = 2
      vb.memory = 8192
      vb.customize ['modifyvm', :id, '--nested-hw-virt', 'on']
      vb.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
    end
    ansible.vm.synced_folder "./Playbooks", "/home/vagrant/Playbooks"
    ansible.vm.provision "shell", path: "Scripts/Setup-Ansible.sh"
  end

  #Windows 10 client instance
  config.vm.define "cl1" do |subconfig|
    subconfig.vm.box = "gusztavvargadr/windows-10"
    subconfig.vm.hostname = "cl1"
    subconfig.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.name = "cl1"
      vb.cpus = 2
      vb.memory = 4096
      vb.customize ['modifyvm', :id, '--nested-hw-virt', 'on']
      vb.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
    end
    subconfig.vm.network "private_network", ip: "172.16.10.31", 
      name: "vboxnet0", :adapter => 2
#	    virtualbox__intnet: true
    subconfig.vm.provision "shell", path: "Scripts/Setup-WinRM.ps1"
    subconfig.vm.provision "shell",
      run: "always",
      inline: "route /p add 0.0.0.0 mask 0.0.0.0 172.16.10.1"
  end

  #Domain Controller 1
  config.vm.define "dc1" do |subconfig|
    subconfig.vm.box = "gusztavvargadr/windows-server"
    subconfig.vm.hostname = "dc1"
    subconfig.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.name = "dc1"
      vb.memory = 16*1024
      vb.cpus = 4
      vb.customize ['modifyvm', :id, '--nested-hw-virt', 'on']
      vb.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
    end
    subconfig.vm.network "private_network", ip: "172.16.10.2", 
      name: "vboxnet0", :adapter => 2
#	    virtualbox__intnet: true
    subconfig.vm.provision "shell", path: "Scripts/Setup-WinRM.ps1"
    subconfig.vm.provision "shell",
      run: "always",
      inline: "route /p add 0.0.0.0 mask 0.0.0.0 172.16.10.1"
  end

  #Elastic server
  config.vm.define "es" do |elastic|
    elastic.vm.box = "generic/ubuntu2004"
    elastic.vm.network "private_network", ip: "172.16.10.8",
      name: "vboxnet0", :adapter => 2
    elastic.vm.hostname = "es"
    elastic.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.name = "es"
      vb.cpus = 2
      vb.memory = 4096
      vb.customize ['modifyvm', :id, '--nested-hw-virt', 'on']
      vb.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
    end
  end

  #kali instance
  config.vm.define "itsec" do |kali|
    kali.vm.box = "kalilinux/rolling"
    kali.vm.network "private_network", ip: "172.16.10.9",
      name: "vboxnet0", :adapter => 2
    kali.vm.hostname = "itsec"
    kali.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.name = "itsec"
      vb.cpus = 2
      vb.memory = 2048
      vb.customize ['modifyvm', :id, '--nested-hw-virt', 'on']
      vb.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
    end
    kali.vm.provision "shell", inline: <<-SHELL
      mkdir /home/vagrant
      mkdir /home/vagrant/Desktop
      touch /home/vagrant/Desktop/ReadMe.txt
      wget -O /home/vagrant/Desktop/ReadMe.txt https://raw.githubusercontent.com/vpasias/windows_sandbox-ansible/master/README.md
    SHELL
  end

  # Cluster Server 1
  config.vm.define "cs1" do |subconfig|
    subconfig.vm.box = "gusztavvargadr/windows-server"
    subconfig.vm.hostname = "cs1"
    subconfig.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.memory = 16*1024
      vb.cpus = 4
      vb.customize ['modifyvm', :id, '--nested-hw-virt', 'on']
      vb.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
    end
    subconfig.vm.network "private_network", ip: "172.16.10.10", 
      name: "vboxnet0", :adapter => 2
    subconfig.vm.provision "shell",
      run: "always",
      inline: "route /p add 0.0.0.0 mask 0.0.0.0 172.16.10.1"
    subconfig.vm.provision "shell", path: "Scripts/Setup-WinRM.ps1"
  end
  
  # Cluster Server 2
  config.vm.define "cs2" do |subconfig|
    subconfig.vm.box = "gusztavvargadr/windows-server"
    subconfig.vm.hostname = "cs2"
    subconfig.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.memory = 16*1024
      vb.cpus = 4
      vb.customize ['modifyvm', :id, '--nested-hw-virt', 'on']
      vb.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
    end
    subconfig.vm.network "private_network", ip: "172.16.10.11", 
      name: "vboxnet0", :adapter => 2
    subconfig.vm.provision "shell",
      run: "always",
      inline: "route /p add 0.0.0.0 mask 0.0.0.0 172.16.10.1"
    subconfig.vm.provision "shell", path: "Scripts/Setup-WinRM.ps1"
  end
  
  # Cluster Server 3
  config.vm.define "cs3" do |subconfig|
    subconfig.vm.box = "gusztavvargadr/windows-server"
    subconfig.vm.hostname = "cs3"
    subconfig.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.memory = 16*1024
      vb.cpus = 4
      vb.customize ['modifyvm', :id, '--nested-hw-virt', 'on']
      vb.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
    end
    subconfig.vm.network "private_network", ip: "172.16.10.12", 
      name: "vboxnet0", :adapter => 2
    subconfig.vm.provision "shell",
      run: "always",
      inline: "route /p add 0.0.0.0 mask 0.0.0.0 172.16.10.1"
    subconfig.vm.provision "shell", path: "Scripts/Setup-WinRM.ps1"
  end

  # Storage Server 1
  config.vm.define "ss1" do |subconfig|
    subconfig.vm.box = "gusztavvargadr/windows-server"
    subconfig.vm.hostname = "ss1"
    subconfig.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.memory = 16*1024
      vb.cpus = 4
      vb.customize ['modifyvm', :id, '--nested-hw-virt', 'on']
      vb.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
    end
    subconfig.vm.network "private_network", ip: "172.16.10.13", 
      name: "vboxnet0", :adapter => 2
    subconfig.vm.provision "shell",
      run: "always",
      inline: "route /p add 0.0.0.0 mask 0.0.0.0 172.16.10.1"
    subconfig.vm.provision "shell", path: "Scripts/Setup-WinRM.ps1"
  end

end
