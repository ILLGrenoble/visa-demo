# -*- mode: ruby -*-
# vi: set ft=ruby :

# Warning : you may need to run `vagrant plugin install vagrant-proxyconf` and `vagrant plugin install vagrant-reload` and `vagrant plugin install vagrant-disksize`

Vagrant.configure("2") do |config|
  config.vm.define :build_image, autostart: false do |bi|

    bi.vm.box = "ubuntu/focal64"
    bi.vm.network "private_network", ip: "172.29.29.50"

    bi.vm.synced_folder "build/", "/build/", create: true

    bi.vm.provider "virtualbox" do |vb|
        vb.memory = "6144"
        vb.cpus = 4
        vb.customize ["modifyvm", :id, "--nested-hw-virt", "on"]
        vb.customize ["modifyvm", :id, "--vram", "128"]
    end
    bi.vm.provision :shell, inline: <<-SHELL
        set -x
        apt-get update
        apt-get install -y qemu qemu-kvm libvirt-daemon-system bridge-utils virt-manager python3-venv python3-pip unzip
        usermod -a -G libvirt vagrant
        usermod -a -G kvm vagrant
        wget -O packer.zip https://releases.hashicorp.com/packer/1.6.4/packer_1.6.4_linux_amd64.zip
        unzip packer.zip
        mv packer /usr/local/bin/packer
    SHELL
    bi.vm.provision :reload
    bi.vm.provision :shell, privileged: false, inline: <<-SHELL
        git clone https://github.com/ILLGrenoble/visa-image-template-example
        cd visa-image-template-example
        sed -i "25i\\        - - \\\"-cpu\\\"" templates/system-base/manifest.yml
        sed -i "26i\\          - \\\"host\\\"" templates/system-base/manifest.yml
        ./build-image.sh -rp visa -hp $http_proxy -np $no_proxy
        cd templates/visa-apps/builds
        qemu-img convert -f qcow2 -O raw visa-apps-qemu.iso visa-apps.img
        mv visa-apps.img /build/
    SHELL
  end

  config.vm.define :visa, primary: true do |visa|
    visa.vm.box = "ubuntu/focal64"
    visa.vm.hostname = "visa"
    visa.vm.network "private_network", ip: "172.29.29.120"
    visa.vm.network "private_network", ip: "10.50.0.120"
    visa.vm.provider "virtualbox" do |vb|
      # Customize the amount of memory on the VM:
      vb.name = "visa_vagrant"
      vb.memory = "4096"
      vb.customize ["modifyvm", :id, "--nested-hw-virt", "on"]
      vb.customize ["modifyvm", :id, "--nic2", "natnetwork", "--nat-network1", "VISAnet"]
    end


    visa.vm.provision "shell", inline: <<-SHELL
    apt-get install -y apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release
    
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
      "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get update
    apt-get install -y docker-ce docker-compose
    usermod -g docker vagrant
    SHELL
    visa.vm.provision :reload
    visa.vm.provision "shell", inline: <<-SHELL
    cp /vagrant/visa-docker.service /etc/systemd/system/
    systemctl enable visa-docker.service
    systemctl start visa-docker.service
    SHELL
  end

  if Vagrant.has_plugin?("vagrant-proxyconf")
    if ENV["http_proxy"]
      config.proxy.http = ENV["http_proxy"]
    end
    if ENV["https_proxy"]
      config.proxy.https = ENV["https_proxy"]
    end
    if ENV["no_proxy"]
      config.proxy.no_proxy = ENV["no_proxy"] + ",keycloak,api,accounts,jupyter-proxy"
    end
  end
end
