execute 'update_package_list' do
  command 'apt-get update'
  action :run
  only_if { platform_family?('debian') } # Solo se ejecuta en sistemas Debian/Ubuntu
end

package "php" do
  action :install
end

package "php-mysql" do
  action :install
end

package "php-mysqli" do
  action :install
end

service "apache2" do
  action :restart
end
