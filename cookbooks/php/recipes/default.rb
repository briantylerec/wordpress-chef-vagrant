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

# Instala PHP y los módulos necesarios
if platform_family?('debian')
  package "php" do
    action :install
  end

  package "php-mysql" do
    action :install
  end

  package "php-mysqli" do
    action :install
  end

  # Reinicia el servicio de Apache en Debian/Ubuntu
  service "apache2" do
    action :restart
  end

elsif platform_family?('rhel')
  package "php" do
    action :install
  end

  package "php-mysql" do
    action :install
  end

  package "php-mysqli" do
    action :install
  end

  # Reinicia el servicio de Apache en CentOS/RHEL
  service "httpd" do
    action :restart
  end
end
