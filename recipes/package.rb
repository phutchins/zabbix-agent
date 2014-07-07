#tmp_dir = node['zabbix_agent']['tmp_dir']

execute "download_zabbix_repo_package" do
  command "wget http://repo.zabbix.com/zabbix/2.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_2.2-1+precise_all.deb -O /tmp/zabbix-release_2.2-1+precise_all.deb"
  action :run
end
execute "install_repo_package" do
  command "dpkg -i zabbix-release_2.2-1+precise_all.deb"
  not_if "dpkg -l | grep zabbix-release"
  action :run
end

execute "apt_get_update" do
  command "apt-get update"
  action :run
end

package 'zabbix-agent' do
  action :install
end
