#####################################################################################
# Terraform module examples are meant to show an _example_ on how to use a module
# per use-case. The code below should not be copied directly but referenced in order
# to build your own root module that invokes this module
#####################################################################################

module "vault_dynamic_secret_mysql" {
  source = "../.."
  # source  = "tf-vault-modules/dynamic-secrets-mysql/vault"
  # version = "1.0.x"

  db_username = "vault-admin"
  db_password = "Pa$$w0rd"
  db_url      = "127.0.0.1:3306"

  roles = [
    {
      role_name : "testorg--wp-1"
    }
  ]
}
