#####################################################################################
# Terraform module examples are meant to show an _example_ on how to use a module
# per use-case. The code below should not be copied directly but referenced in order
# to build your own root module that invokes this module
#####################################################################################

module "vault_dynamic_secret_mysql" {
  source = "../.."
  # source  = "tf-vault-modules/dynamic-secrets-mysql/vault"
  # version = "1.0.x"


  vault_mount_path = "dynamic-db-full"
  db_username      = "vault-admin"
  db_password      = "Pa$$w0rd"
  db_url           = "127.0.0.1:3306"
  connection_name  = "mysql"
  allowed_roles    = ["*"]

  roles = [
    {
      role_name : "role-db-1"
      database_name : "db-1"
      quota : {
        max_leases : 10
      }
      creation_statements = [
        "CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';",
        "GRANT SELECT, UPDATE, INSERT, DELETE, ALTER, CREATE, DROP, ALTER, INDEX ON `db-1`.* TO '{{name}}'@'%';"
      ],
      default_ttl = "4m"
      max_ttl     = "10m"
      quota = {
        rate : 10
        interval : 10
        block_interval : 10
      }
    },
    {
      role_name : "role-db-2"
      database_name : "db-2"
      quota = {
        max_leases : 10
      }
      creation_statements = [
        "CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';",
        "GRANT SELECT, UPDATE, INSERT, DELETE, ALTER, CREATE, DROP, ALTER, INDEX ON `db-2`.* TO '{{name}}'@'%';"
      ],
      default_ttl = "4m"
      max_ttl     = "10m"
      quota : {
        rate : 10
        interval : 10
        block_interval : 10
      }
    },
  ]
}
