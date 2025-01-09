# Actualiza la lista de paquetes solo si es necesario
if platform_family?('debian')
  execute 'update_package_list' do
    command 'apt-get update'
    action :run
  end
elsif platform_family?('rhel')
  execute 'update_package_list' do
    command 'yum makecache'
    action :run
  end
end

# Instala MySQL y el servidor
if platform_family?('debian')
  package "mysql-server" do
    action :install
  end

  service "mysql" do
    action [:enable, :start]
  end

elsif platform_family?('rhel')
  package "mysql-server" do
    action :install
  end

  service "mysqld" do
    action [:enable, :start]
  end
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
