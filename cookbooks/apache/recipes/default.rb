# Instalar Apache según la plataforma
package_name = case node['platform_family']
  when 'debian' then 'apache2'
  when 'rhel' then 'httpd'
  else raise "Unsupported platform: #{node['platform_family']}"
  end
package package_name do
  action :install
end

#iniciar y habilitar servicio de apache
service package_name do
  action [:enable, :start]
end

# Definir la ruta del archivo de configuración
config_path = case node['platform_family']
  when 'debian' then '/etc/apache2/sites-available/wordpress.conf'
  when 'rhel' then '/etc/httpd/conf.d/wordpress.conf'
  else raise "Unsupported platform: #{node['platform_family']}"
  end


template config_path do
  case node['platform_family']
  when 'debian'
    source "wordpress.conf_debian.erb"
  when 'rhel'
    source "wordpress.conf_redhat.erb"
  end
  mode "0644"
  notifies :restart, "service[#{package_name}]", :immediately
end

# Configuración adicional para habilitar el sitio y módulos de Apache
bash "configure_apache" do
  code <<-EOH
    #{case node['platform_family']
      when 'debian'
        <<-UBUNTU_COMMANDS
          a2ensite wordpress.conf
          a2dissite 000-default.conf
          a2enmod rewrite
          systemctl restart apache2
        UBUNTU_COMMANDS
      when 'rhel'
        <<-RHEL_COMMANDS
          sed -i 's/^/#/' /etc/httpd/conf.d/welcome.conf
          echo "RewriteEngine On" >> /etc/httpd/conf/httpd.conf
          service httpd restart
        RHEL_COMMANDS
      end}
  EOH
end
