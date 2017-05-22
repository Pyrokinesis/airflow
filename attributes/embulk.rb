default[:embulk] = {
  :bin          => "/usr/local/bin/embulk",
  :jar          => "/usr/local/bin/embulk.jar",
  :download_uri => "http://dl.embulk.org/embulk-latest.jar",
  :lib_dir      => "/var/lib/embulk",
  :config_dir   => "/var/lib/embulk/config",
  :user         => "root",
  :group        => "root",
  :plugins      => [
    {:name => "embulk-input-zendesk", :version => "0.1.12",},
    {:name => "embulk-output-redshift", :version => "0.7.2",},
    {:name => "embulk-output-s3", :version => "1.3.0",},
  ],
}
