tmp_dir = node['zabbix_agent']['tmp_dir']
extracted_name = node['zabbix_agent']['extracted_name']
download_url = node['zabbix_agent']['source_download_url']
download_file = node['zabbix_agent']['source_download_file']

case node['platform']
when 'ubuntu', 'debian'
  %w(fping libcurl3 libiksemel-dev libiksemel3 libsnmp-dev libiksemel-utils libcurl4-openssl-dev).each do |pck|
    package pck do
      action :install
    end
  end
end

remote_file File.join(tmp_dir, download_file) do
  source File.join(download_url, download_file)
  action :create
end

execute "extract_archive" do
  command "tar -zxvf #{File.join(tmp_dir, download_file)} -C #{tmp_dir}"
  not_if { File.exists?("#{File.join(tmp_dir, extracted_name)}") }
end
