execute 'update_package_list' do
  command 'apt-get update'
  action :run
  only_if { platform_family?('debian') } # Solo se ejecuta en sistemas Debian/Ubuntu
end

package "mysql-server" do
  action :install
end

service "mysql" do
  action [:enable, :start]
end

bash "create_wordpress_db" do
  code <<-EOH
    mysql -uroot -e "CREATE DATABASE wordpress;"
    mysql -uroot -e "CREATE USER 'wordpress_user'@'localhost' IDENTIFIED BY 'password';"
    mysql -uroot -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress_user'@'localhost';"
    mysql -uroot -e "FLUSH PRIVILEGES;"
  EOH
  not_if "mysql -uroot -e 'SHOW DATABASES;' | grep wordpress"
  action :run
  only_if { ::File.exist?('/usr/bin/mysql') }
end
