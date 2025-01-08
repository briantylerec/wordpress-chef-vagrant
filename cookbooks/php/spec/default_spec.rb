#
# Cookbook:: php
# Spec:: default
#
# Copyright:: 2024, The Authors, All Rights Reserved.

require 'chefspec'

describe 'php::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '20.04') do |node|
      # Aquí puedes configurar atributos del nodo si es necesario
    end.converge(described_recipe)
  end

  context 'When all attributes are default, on Ubuntu 20.04' do
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs php package' do
      expect(chef_run).to install_package('php')
    end

    it 'installs php-mysql package' do
      expect(chef_run).to install_package('php-mysql')
    end

    it 'installs php-mysqli package' do
      expect(chef_run).to install_package('php-mysqli')
    end

    it 'restarts the apache2 service' do
      expect(chef_run).to restart_service('apache2')
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

    it 'installs php package' do
      expect(chef_run).to install_package('php')
    end

    it 'installs php-mysql package' do
      expect(chef_run).to install_package('php-mysql')
    end

    it 'installs php-mysqli package' do
      expect(chef_run).to install_package('php-mysqli')
    end

    it 'restarts the apache2 service' do
      expect(chef_run).to restart_service('apache2')
    end
  end
end
