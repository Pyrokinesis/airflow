# Just in case we want to export env without running initdb
# bash 'export_env' do
#   code 'source /etc/default/airflow'
# end

execute "do init" do
  cwd "/home/airflow"
  user "airflow"
  environment ({'AIRFLOW_HOME' => '/usr/local/lib/airflow', 'USER' => 'airflow'})
  command "airflow initdb"
  action :run
end

service 'airflow-webserver' do
  action :start
end

