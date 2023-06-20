#####################################################################################
# Terraform module examples are meant to show an _example_ on how to use a module
# per use-case. The code below should not be copied directly but referenced in order
# to build your own root module that invokes this module
#####################################################################################

module "vault_dynamic_secret_mysql" {
  source = "../.."

  vault_mount_path = "database"
  db_username      = "vault-admin"
  db_password      = "root"
  db_url           = "mariadb:3306"
  connection_name  = "mysql"
  allowed_roles    = ["*"]

  # lease_count_enabled = false

  # default_creation_statements   = [
  #   "CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';",
  #   "GRANT ALL PRIVILEGES ON *.* TO '{{name}}'@'%';"
  # ]

  roles = [
    {
      role_name : "main"
      database_name : "wp-vault-test"
      quota : {
        max_leases : 10
      }
      # ONLY NEEDED PERMISSIONS FOR WORDPRESS DATABASE
      creation_statements = [
        "CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';",
        "GRANT SELECT, UPDATE, INSERT, DELETE, ALTER, CREATE, DROP, ALTER, INDEX ON `wp-vault-test`.* TO '{{name}}'@'%';"
      ]
    },
    {
      role_name : "vault-wp-organization"
      database_name : "wp-vault-test"
      quota : {}
    },
    {
      role_name : "maginfo-wp-2"
      database_name : "wp-2"
    },
    {
      role_name : "maginfo"
      database_name : "wp-1"
    },

  ]
}
