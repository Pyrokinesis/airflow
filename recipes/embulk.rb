package "curl"

bash "download embulk.jar" do
  user  node[:embulk][:user]
  group node[:embulk][:group]
  code  <<-EOC
  curl -L #{node[:embulk][:download_uri]} -o #{node[:embulk][:jar]}
  chmod +x #{node[:embulk][:jar]}
EOC
  creates node[:embulk][:jar]
end

group node[:embulk][:group] do
  system true
end

user node[:embulk][:user] do
  system true
  group  node[:embulk][:group]
end

directory node[:embulk][:lib_dir] do
  owner node[:embulk][:user]
  group node[:embulk][:group]
  mode  0755
end

directory node[:embulk][:config_dir] do
  owner node[:embulk][:user]
  group node[:embulk][:group]
  mode  0755
end

# node[:embulk][:plugins].each do |k, v|
#   execute "install_plugins_#{k}" do 
#     command "#{node[:embulk][:jar]} gem install ['name'] ['version']"
#   end
# end
# 
# node[:embulk][:plugins].each do |plugins|
#   execute "install_plugin_#{plugins}" do
#     command "#{node[:embulk][:jar]} gem install #{node[:embulk][:plugins][:name]} #{node[:embulk][:plugins][:version]}"
#   end
# end

%w{embulk-input-zendesk embulk-output-redshift embulk-output-s3}.each do |plugin|
  execute "install_#{plugin}" do
  cwd "/home/airflow"
  user "airflow"
    command "/usr/local/bin/embulk.jar gem install #{plugin}"
  end
end

execute "do init" do
  cwd "/home/airflow"
  user "airflow"
  environment ({'AIRFLOW_HOME' => '/usr/local/lib/airflow', 'USER' => 'airflow'})
  command "mkdir -p ${AIRFLOW_HOME}/embulk_diffs/{zendesk,talkdesk}"
  action :run
end
