require 'spec_helper'

#describe package('httpd') do			# Resource(何をテストするか)
#  it { should be_installed }			# Matcher(どうあるべきか)
#end

# eachメソッドを使用
%w(httpd php-5.4.16 mariadb-server-5.5.60 rh-ruby25-ruby python36 python36-pip).each do |pkg|
  describe package(pkg) do
    it { should be_installed }			# 該当パッケージがインストールされていること
  end
end

#describe service('httpd') do
#  it { should be_running }			# httpdサービスが起動していること
#  it { should be_enabled }			# httpdサービスが起動時に有効になること
#end

%w(httpd mariadb firewalld).each do |src|
  describe service(src) do
    it { should be_running }			# 該当サービスが起動していること
    it { should be_enabled }			# 該当サービスが起動時に有効になること
  end
end

describe port(80) do
  it { should be_listening }			# 80番ポートが空いていること
end

describe command('firewall-cmd --list-ports') do
  its(:stdout) { should match /3000\/tcp/ }	# 3000番ポートが空いていること
end

describe command('mysql -uwpadmin -pwpadmin -e"show databases;"') do
  its(:stdout) { should match /wp/ }		# wpデータベースが作成されている
end

describe file('/var/www/html/phpinfo.php') do
  it { should be_file }				# /var/www/html/phpinfo.phpというファイルが存在すること
  it { should be_owned_by 'root' }		# ファイルオーナーがrootであること
  it { should be_grouped_into 'root' }		# グループがrootであること
  its(:content) { should match /phpinfo/ }	# phpinfoという文字列にマッチする
end

describe file('/root/.my.cnf') do
  it { should be_file }
  its(:content) { should match /\[client\]/ }	# [client]という文字列にマッチする
end

describe file('/root/.bashrc') do
  it { should be_file }
  its(:content) { should match /\/opt\/rh\/rh-ruby25\/enable/ }	# 左記の文字列にマッチする
end
