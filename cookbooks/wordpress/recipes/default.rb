# Install WP-CLI
  bash "install_wp_cli" do
    code <<-EOH
      curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
      chmod +x wp-cli.phar
      mv wp-cli.phar /usr/local/bin/wp
    EOH
    not_if { ::File.exist?("/usr/local/bin/wp") }
  end
  
  # Download and setup WordPress
  bash "download_wordpress" do
    code <<-EOH
      wget https://wordpress.org/latest.tar.gz
      tar -xzvf latest.tar.gz -C /var/www/html
      mv /var/www/html/wordpress /var/www/html/blog
      chown -R www-data:www-data /var/www/html/blog
      chmod -R 755 /var/www/html/blog
    EOH
    not_if { ::File.exist?("/var/www/html/blog/index.php") }
  end
  
  # Setup wp-config.php file
  template "/var/www/html/blog/wp-config.php" do
    source "wp-config.php.erb"
    mode "0644"
    owner "www-data"
    group "www-data"
  end
  
  # InstInstall WordPress
  bash "install_wordpress" do
    code <<-EOH
      wp core install --url="http://localhost:8080" \
        --title="My Blog" \
        --admin_user="admin" \
        --admin_password="admin_password" \
        --admin_email="admin@example.com" \
        --path=/var/www/html/blog --allow-root
    EOH
    not_if "wp core is-installed --path=/var/www/html/blog --allow-root"
  end
  
  # Setup first blog
  bash "configure_blog" do
    code <<-EOH
      wp post create --post_title="Hello World" --post_content="This is an automated blog post." \
        --post_status="publish" --path=/var/www/html/blog --allow-root
      wp theme activate twentytwentyone --path=/var/www/html/blog --allow-root
    EOH
    not_if "wp post list --path=/var/www/html/blog --allow-root | grep 'Hello World'"
  end
  
  # Set right permissions
  bash "set_permissions" do
    code <<-EOH
      chown -R www-data:www-data /var/www/html/blog
      chmod -R 755 /var/www/html/blog
    EOH
  end
  