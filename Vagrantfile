Vagrant.configure("2") do |config|

  config.vm.define "master" do |master|
    master.vm.box = "ubuntu/bionic64"
    master.vm.hostname = "master"
    master.vm.network "private_network", ip: "192.168.254.2"
    master.vm.provision :shell, path: "tests/files/provision-script.sh"
    master.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end
  end

  config.vm.define "worker1" do |worker1|
    worker1.vm.box = "ubuntu/bionic64"
    worker1.vm.hostname = "worker1"
    worker1.vm.network "private_network", ip: "192.168.254.3"
    worker1.vm.provision :shell, path: "tests/files/provision-script.sh"
    worker1.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end
  end

  config.vm.define "worker2" do |worker2|
    worker2.vm.box = "ubuntu/bionic64"
    worker2.vm.hostname = "worker2"
    worker2.vm.network "private_network", ip: "192.168.254.4"
    worker2.vm.provision :shell, path: "tests/files/provision-script.sh"
    worker2.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end
  end

  config.vm.define "worker3" do |worker3|
    worker3.vm.box = "ubuntu/bionic64"
    worker3.vm.hostname = "worker3"
    worker3.vm.network "private_network", ip: "192.168.254.5"
    worker3.vm.provision :shell, path: "tests/files/provision-script.sh"
    worker3.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end
  end

  config.vm.define "client" do |client|
    client.vm.box = "ubuntu/bionic64"
    client.vm.hostname = "client"
    client.vm.network "private_network", ip: "192.168.254.6"
    client.vm.provision :shell, path: "tests/files/install-pip.sh"
    client.vm.provision :shell, path: "tests/files/provision-script.sh"
    client.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.cpus = 1
    end
  end
end