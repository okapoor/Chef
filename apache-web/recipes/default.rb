# install all required package


node['packages_to_install'].each do |pack|
  package pack
end

# create groups
node['groups'].each do |g|
  #here we just write group g since default action is create
  group g
end



#create users
node['users'].each do |u|
  user u do
    home File.join("#{node['base_user_dir']}", u)
    manage_home true      # creates home directory if it doesn't exist
    shell node['default_shell']
    group node['usergroups'][u]
  end
end


# setup base app dir
directory '#{node[approot]}'


#setup private key to access github, I have set this up under files


cookbook_file '/root/.ssh/id_rsa' do
  source 'id_rsa'
  owner 'root'
  group 'root'
  mode '400'
end

# clone githb repo for nyt search


git File.join(node['approot'], node['repository_name']) do
  repository node['repository_url']
  reference 'master'
  action :sync
end

file '/etc/httpd/conf/httpd.conf' do
  action :delete
end

template '/etc/httpd/conf/httpd.conf' do
  source 'httpd.conf.erb'
  mode '0755'
  owner 'apache_admin'
  group 'apache_admin'
  variables(
    document_root: File.join("#{node['approot']}", "#{node['repository_name']}")
  )
end


#enable all packages that require a start/enable -- in our case start apache
node['packages_to_enable'].each do |pack_enable|
  service pack_enable do
    action [:enable, :restart]
  end
end

