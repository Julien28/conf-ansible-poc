# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

ansible = [
  { :hostname => 'poc-ansible',   :ip => '192.168.0.100', :box => 'ubuntu/xenial64' },
]

nodes = [
  { :hostname => 'poc-web1',      :ip => '192.168.0.101', :box => 'ubuntu/xenial64' },
  { :hostname => 'poc-web2',    :ip => '192.168.0.102', :box => 'ubuntu/xenial64' },
  { :hostname => 'poc-bdd1',    :ip => '192.168.0.103', :box => 'ubuntu/xenial64' },
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  ansible.each do |ans|
    config.vm.define ans[:hostname] do |ansconfig|
      ansconfig.vm.box = "ubuntu/xenial64"
      ansconfig.vm.hostname = ans[:hostname] + ".local"
      ansconfig.vm.network :private_network, ip: ans[:ip]
      ansconfig.vm.provision "file", source: "id_rsa", destination: "/tmp/id_rsa"
	  ansconfig.vm.provision "file", source: "id_rsa.pub", destination: "/tmp/id_rsa.pub"
	  ansconfig.vm.provision "file", source: "hosts", destination: "/tmp/hosts"
      ansconfig.vm.provision "shell", path: "ansible.bash"
      memory = ans[:ram] ? ans[:ram] : 256;
      ansconfig.vm.provider :virtualbox do |vb|
        vb.customize [
          "modifyvm", :id,
          "--cpuexecutioncap", "50",
          "--memory", memory.to_s,
        ]
	  end
    end
  end
  
  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.box = "ubuntu/xenial64"
      nodeconfig.vm.hostname = node[:hostname] + ".local"
      nodeconfig.vm.network :private_network, ip: node[:ip]
      nodeconfig.vm.provision "shell", path: "authorized_keys.bash"
      memory = node[:ram] ? node[:ram] : 256;
      nodeconfig.vm.provider :virtualbox do |vb|
        vb.customize [
          "modifyvm", :id,
          "--cpuexecutioncap", "50",
          "--memory", memory.to_s,
        ]
	  end
    end
  end
 
end