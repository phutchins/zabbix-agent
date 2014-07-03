#package 'zabbix-agent' do
#  action :install
#end
tmp_dir = node['zabbix_agent']['tmp_dir']

script "download_and_install_zabbix_package" do
  command "cd #{tmp_dir} && wget http://repo.zabbix.com/zabbix/2.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_2.2-1+precise_all.deb && dpkg -i zabbix-release_2.2-1+precise_all.deb"
  not_if "dpkg -l | grep zabbix-release"
end
