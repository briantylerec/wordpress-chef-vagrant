
if os[:family] == 'redhat'
  puts "Ejecutando pruebas para el sistema operativo: #{os[:family]}"

  #validacion de instalacion
  describe package('httpd') do
    it { should be_installed }
  end

  #validacion de estado
  describe service('httpd') do
    it { should be_enabled }
    it { should be_running }
  end

  #validacion archivo de configuracion
  describe file('/etc/httpd/conf/httpd.conf') do
    it { should exist }
    it { should be_file }
  end

elsif os[:family] == 'debian'
  puts "Ejecutando pruebas para el sistema operativo: #{os[:family]}"
  
  #validacion de instalacion
  describe package('apache2') do
    it { should be_installed }
  end

  #validacion de estado
  describe service('apache2') do
    it { should be_enabled }
    it { should be_running }
  end

  #validacion archivo de configuracion
  describe file('/etc/apache2/apache2.conf') do
    it { should exist }
    it { should be_file }
  end
end
