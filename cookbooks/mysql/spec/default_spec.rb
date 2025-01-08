require 'chefspec'

describe 'mysql::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '20.04') do |node|
      # Aquí puedes configurar atributos del nodo si es necesario
    end.converge(described_recipe)
  end

  context 'When all attributes are default, on Ubuntu 20.04' do
    before do
      # Simular que la base de datos no existe al principio
      stub_command("mysql -uroot -e 'SHOW DATABASES;' | grep wordpress").and_return("")
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs mysql-server package' do
      expect(chef_run).to install_package('mysql-server')
    end

    it 'enables and starts mysql service' do
      expect(chef_run).to enable_service('mysql')
      expect(chef_run).to start_service('mysql')
    end
  end
end

