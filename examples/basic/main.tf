#####################################################################################
# Terraform module examples are meant to show an _example_ on how to use a module
# per use-case. The code below should not be copied directly but referenced in order
# to build your own root module that invokes this module
#####################################################################################

module "vault_dynamic_secret_mysql" {
  source = "../.."

  vault_mount_path = "database"
  db_username = "vault-admin"
  db_password = "123123"
  db_url = "localhost:3306"
  connection_name = "mysql"

  roles = [
    {
      role_name: "main"
      database_name: "wp-vault-test"
    },
    {
      role_name: "vault-wp-organization"
      database_name: "wp-vault-test"
    },
    {
      role_name: "dnb"
      database_name: "wp-1"
    },
    {
      role_name: "maginfo"
      database_name: "wp-1"
    },

  ]
}
