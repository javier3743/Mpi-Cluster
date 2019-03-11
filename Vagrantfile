# -*- mode: ruby -*-
# vi: set ft=ruby :

class VagrantPlugins::ProviderVirtualBox::Action::Network
  def dhcp_server_matches_config?(dhcp_server, config)
    true
  end
end

Vagrant.configure("2") do |config|
  config.vm.define "master" do |master|
  	master.vm.box = "ubuntu/bionic64"
        master.vm.hostname = "master.localhost"
        master.vm.network "private_network", ip: "192.168.56.3", :name => 'vboxnet0'
        master.vm.network :forwarded_port, guest: 8080, host: 8081
        master.vm.network :forwarded_port, guest: 80, host: 8080, guest_ip: "192.168.56.3"
  	master.vm.provider :virtualbox do |vb|
		vb.customize [ 'modifyvm', :id, '--memory', '1500' ]
		vb.customize [ 'modifyvm', :id, '--cpus', '1' ]
		vb.customize [ 'modifyvm', :id, '--name', 'cluster-master' ]
  	end
        master.vm.provision "shell", path: "master.sh"
    end
  (1..2).each do |i|
   config.vm.define "node#{i}" do |m|
        m.vm.box = "ubuntu/bionic64"
        m.vm.hostname = "node-0#{i}.localhost"
        m.vm.network "private_network", :type => 'dhcp', :name => 'vboxnet0'
        m.vm.provider :virtualbox do |vb|
		vb.customize [ 'modifyvm', :id, '--memory', '750' ]
		vb.customize [ 'modifyvm', :id, '--cpus', '1' ]
		vb.customize [ 'modifyvm', :id, '--name', "cluster-node-#{i}" ]
  	end        
        m.vm.provision "shell", path: "client.sh"
        m.vm.provision "shell",
                inline: "sudo  sed -i -e 's/W/W#{i}/g' /var/www/html/index.html"
       end      
   end
end

