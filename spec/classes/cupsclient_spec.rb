require 'spec_helper'

describe 'cupsclient' do

  context 'on unsupported distributions' do
    let(:facts) {{ :osfamily => 'Unsupported' }}

    it 'it fails' do
      expect { subject.call }.to raise_error(/is not supported on an Unsupported based system/)
    end
  end

  context 'on Debian with default parameters' do
    let(:facts) {{
      :osfamily => 'Debian',
      :lsbdistid => 'Debian',
      :lsbdistcodename => 'jessie'
    }}

    it { should contain_class('cupsclient') }

    describe 'package installation' do
      it { should contain_package('cups-client').with(
        'ensure' => 'installed',
        'name'   => 'cups-client'
      )}
    end

    describe 'add configuration file' do
      it { should contain_file('/etc/cups/').with(
        'ensure' => 'directory',
        'path'   => '/etc/cups/',
        'owner'  => 'root',
        'group'  => 'lp',
      )}

      it { should contain_file('client.conf').with(
        'ensure' => 'file',
        'path'   => '/etc/cups/client.conf',
        'owner'  => 'root',
        'group'  => 'lp',
      )}
    end
  end

  context 'on Debian with modified parameters' do
    let(:facts) {{
      :osfamily => 'Debian',
      :lsbdistid => 'Debian',
      :lsbdistcodename => 'jessie'
    }}

    let(:params) {{
      :allowanyroot      => 'Yes',
      :allowexpiredcerts => 'Yes',
      :encryption        => 'Required',
      :gssservicename    => 'name@server.example.com',
      :servername        => 'foo.bar',
      :ssloptions        => 'None',
      :user              => 'nobody',
      :validatecerts     => 'Yes',
    }}

    describe 'add configuration file' do
      it { should contain_file('/etc/cups/').with(
        'ensure' => 'directory',
        'path'   => '/etc/cups/',
        'owner'  => 'root',
        'group'  => 'lp',
      )}

      it { should contain_file('client.conf').with(
        'ensure' => 'file',
        'path'   => '/etc/cups/client.conf',
        'owner'  => 'root',
        'group'  => 'lp',
      )}
    end

    describe 'modify configuration file' do
      it { should contain_file('client.conf') \
        .with_content(/AllowAnyRoot Yes/) \
        .with_content(/AllowExpiredCerts Yes/) \
        .with_content(/Encryption Required/) \
        .with_content(/GSSServiceName name@server.example.com/) \
        .with_content(/ServerName foo.bar/) \
        .with_content(/SSLOptions None/) \
        .with_content(/User nobody/) \
        .with_content(/ValidateCerts Yes/) }
    end
  end

end
