# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

# liste d'instance Ansible
ansible = [
  { :hostname => 'poc-ansible',   :ip => '192.168.0.100', :box => 'ubuntu/xenial64' },
]

# liste d'instances POC
nodes = [
  { :hostname => 'poc-web1',      :ip => '192.168.0.101', :box => 'ubuntu/xenial64' },
  { :hostname => 'poc-web2',    :ip => '192.168.0.102', :box => 'ubuntu/xenial64' },
  { :hostname => 'poc-bdd1',    :ip => '192.168.0.103', :box => 'ubuntu/xenial64' },
]

# choix de version de l'API Vagrant
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|			

  # pour chaque éléments dans la liste ansible
  ansible.each do |ans|
    # création de l'enveloppe de la VM
    config.vm.define ans[:hostname] do |ansconfig|
	  # paramétrage de la VM courante (de la liste configurée)
      ansconfig.vm.box = "ubuntu/xenial64"
      ansconfig.vm.hostname = ans[:hostname] + ".local"
      ansconfig.vm.network :private_network, ip: ans[:ip]
	  # copie de fichiers du répertoire courant vers les destinations configurées
      ansconfig.vm.provision "file", source: "id_rsa", destination: "/tmp/id_rsa"
	  ansconfig.vm.provision "file", source: "id_rsa.pub", destination: "/tmp/id_rsa.pub"
	  ansconfig.vm.provision "file", source: "hosts", destination: "/tmp/hosts"
	  # envoie du script dans la VM et l'execute
      ansconfig.vm.provision "shell", path: "ansible.bash"
      memory = ans[:ram] ? ans[:ram] : 512;
	  # customisation de la VM
      ansconfig.vm.provider :virtualbox do |vb|
        vb.customize [
          "modifyvm", :id,
          "--cpuexecutioncap", "50",
          "--memory", memory.to_s,
        ]
	  end
    end
  end
 
  # pour chaque éléments dans la liste nodes 
  nodes.each do |node|
    # création de l'enveloppe des VM
    config.vm.define node[:hostname] do |nodeconfig|
	  # paramétrage de la VM courante (de la liste configurée)
      nodeconfig.vm.box = "ubuntu/xenial64"
      nodeconfig.vm.hostname = node[:hostname] + ".local"
      nodeconfig.vm.network :private_network, ip: node[:ip]
	  # envoie du script dans la VM et l'execute
      nodeconfig.vm.provision "shell", path: "authorized_keys.bash"
      memory = node[:ram] ? node[:ram] : 512;
	  # customisation de la VM
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