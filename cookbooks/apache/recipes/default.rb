package "apache2" do
  action :install
end

service "apache2" do
  action [:enable, :start]
end

template "/etc/apache2/sites-available/wordpress.conf" do
  source "wordpress.conf.erb"
  mode "0644"
end

bash "enable_wordpress_site" do
  code <<-EOH
    a2ensite wordpress.conf
    a2dissite 000-default.conf
    a2enmod rewrite
    systemctl restart apache2
  EOH
end
  