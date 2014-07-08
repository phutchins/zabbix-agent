tmp_dir = node['zabbix_agent']['tmp_dir']
platform = node['platform']
repo_package_url = node['zabbix_agent'][platform]['repo_package_url']
repo_package_name = node['zabbix_agent'][platform]['repo_package_name']

execute "download_zabbix_repo_package" do
  command "wget #{File.join(repo_package_url, repo_package_name)} -O #{File.join(tmp_dir, repo_package_name)}"
  action :run
end

case node['platform']
when 'ubuntu', 'debian'
  execute "install_repo_package" do
    command "dpkg -i #{File.join(tmp_dir, repo_package_name)}"
    not_if "dpkg -l | grep zabbix-release"
    action :run
  end

  execute "apt_get_update" do
    command "apt-get update"
    action :run
  end
end

include_recipe 'zabbix-agent::package'
