#####################################################################################
# Terraform module examples are meant to show an _example_ on how to use a module
# per use-case. The code below should not be copied directly but referenced in order
# to build your own root module that invokes this module
#####################################################################################

module "vault_dynamic_secret_mysql" {
  source = "../.."
  # source  = "tf-vault-modules/dynamic-secrets-mysql/vault"
  # version = "1.0.x"


  vault_mount_path = "database"
  db_username      = "vault-admin"
  db_password      = "root"
  db_url           = "127.0.0.1:3306"
  connection_name  = "mysql"
  allowed_roles    = [] # Optional: ["*"] or manual list of roles. If omitted, will be generated from the roles list

  roles = [
    {
      role_name : "testorg--wp-1"
      allowed : false
    },
    {
      role_name : "main"
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
      role_name : "google--wp-1"
      quota : {}
    },
    {
      role_name : "org1--wp-1"
    },
    {
      role_name : "maginfo-wp-1"
    },

  ]
}
