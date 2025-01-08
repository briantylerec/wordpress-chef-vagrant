#
# Cookbook:: apache
# Spec:: default
#
# Copyright:: 2024, The Authors, All Rights Reserved.

require 'chefspec'

describe 'apache::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '20.04') do |node|
      # Aquí puedes configurar atributos del nodo si es necesario
    end.converge(described_recipe)
  end

  context 'When all attributes are default, on Ubuntu 20.04' do
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'ensures apache2 package is installed' do
      expect(chef_run).to install_package('apache2')
    end

    it 'ensures apache2 service is running' do
      expect(chef_run).to start_service('apache2')
      expect(chef_run).to enable_service('apache2')
    end
  end

  context 'When all attributes are default, on CentOS 7' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '7') do |node|
        # Aquí puedes configurar atributos del nodo si es necesario
      end.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end