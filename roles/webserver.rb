{
  "name"  => "webserver",
  "description" => "Web Server",
  "json_class" => "Chef::Role",
  "default_attributes" => {
    "apache" => {
      "sites" => {
        "admin" => {
          "port" => 82
        }
      }
    }
  },
  "chef_type" => "role",
  "run_list" => [
    "recipe[apache2]",
    "recipe[python]",
    "recipe[mysql::server]"
  ]
}
