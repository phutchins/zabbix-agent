case node['zabbix_agent']['install_method']
when 'source'
  include_recipe 'zabbix-agent::source'
when 'package'
  include_recipe 'zabbix-agent::package'
end

service 'zabbix-agent' do
  action :nothing
end

template '/etc/zabbix/zabbix_agentd.conf' do
  action :create
  notifies :restart, 'service[zabbix-agent]'
end
