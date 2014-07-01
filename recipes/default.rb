case node['zabbix_agent']['install_method']
when 'source'
  include_recipe 'zabbix-agent::source'
when 'package'
  include_recipe 'zabbix-agent::package'
end

template '/etc/zabbix/zabbix_agentd.conf' do
  action :create
end
