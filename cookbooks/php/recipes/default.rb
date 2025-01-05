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
  