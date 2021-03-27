# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vagrant.plugins = "vagrant-reload"

  #ansible controller
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
    end
    ansible.vm.synced_folder "./Playbooks", "/home/vagrant/Playbooks"
    ansible.vm.provision "shell", path: "Scripts/Setup-Ansible.sh"
  end

  #windows 10 instance
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
    subconfig.winrm.username = "vagrant"
    subconfig.winrm.password = "vagrant"
    subconfig.winrm.transport = :plaintext
    subconfig.winrm.basic_auth_only = true 
    subconfig.vm.provision "shell", path: "Scripts/Setup-WinRM.ps1"
    subconfig.vm.provision "shell",
      run: "always",
      inline: "route /p add 0.0.0.0 mask 0.0.0.0 172.16.10.1"
  end

  #domain controller server
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
    subconfig.winrm.username = "vagrant"
    subconfig.winrm.password = "vagrant"
    subconfig.winrm.transport = :plaintext
    subconfig.winrm.basic_auth_only = true 
    subconfig.vm.provision "shell", path: "Scripts/Setup-WinRM.ps1"
    subconfig.vm.provision "shell",
      run: "always",
      inline: "route /p add 0.0.0.0 mask 0.0.0.0 172.16.10.1"
  end

  #elastic server
  config.vm.define "Elastic-Server" do |elastic|
    elastic.vm.box = "hashicorp/bionic64"
    elastic.vm.network "private_network", ip: "172.16.10.10",
      virtualbox__intnet: true
    elastic.vm.hostname = "elastic"
    elastic.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.name = "elastic-server"
      vb.cpus = 2
      vb.memory = 4096
    end
  end

  #kali instance
  config.vm.define "Kali-Box" do |kali|
    kali.vm.box = "kalilinux/rolling"
    kali.vm.network "private_network", ip: "172.16.10.56",
      virtualbox__intnet: true
    kali.vm.hostname = "kali-box"
    kali.vm.provider "virtualbox" do |vb|
      vb.gui = true
      vb.name = "kali-box"
      vb.cpus = 2
      vb.memory = 2048
    end
    kali.vm.provision "shell", inline: <<-SHELL
      mkdir /home/vagrant
      mkdir /home/vagrant/Desktop
      touch /home/vagrant/Desktop/ReadMe.txt
      wget -O /home/vagrant/Desktop/ReadMe.txt https://raw.githubusercontent.com/leonx3264/vagrant-lab-example/master/README.md
    SHELL
  end

end
