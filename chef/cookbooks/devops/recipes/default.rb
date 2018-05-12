# Shortcut to execute chef-solo
file '/usr/local/bin/provision' do
  content "#!/bin/bash \n chef-solo -c /vagrant/chef/solo.rb -j /vagrant/chef/roles/$HOSTNAME.json"
  mode '0733'
  owner 'root'
  group 'root'
end

#Install AWS-SAM-CLI related tasks
docker_service 'default' do
  action [:create, :start]
end

python_runtime '2'
#Install aws-sam-cli
python_package 'awscli'
python_package 'aws-sam-cli'


#Common packages
package ['python3-pip', 'tree']
