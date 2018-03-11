node.default['packages_to_install'] = ['httpd', 'git']
node.default['packages_to_enable'] = ['httpd']
node.default['http']['root']='/var/www/html'
node.default['hostnamee'] = 'cheftestserver'
node.default['default_shell'] = '/bin/bash'
node.default['base_user_dir'] = '/home'
node.default['approot'] = '/app'
node.default['repository_url'] = 'https://github.com/okapoor/nyt-search.git'
node.default['repository_name'] = 'nyt-search'
node.default['groups'] = ['apache_admin']
node.default['users'] = ['apache_admin']
node.default['usergroups'] = {
  'apache_admin' => 'apache_admin'
}
