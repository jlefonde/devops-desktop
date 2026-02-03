Vagrant.configure("2") do |config|
  config.vm.box = "jlefonde/debian12-devops-desktop"
  config.vm.box_version = "1.0.0"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "16384"
    vb.cpus = "12"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansible/vagrant.yml"
  end
end