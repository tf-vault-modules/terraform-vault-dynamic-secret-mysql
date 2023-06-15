#------------------------------------------------------------------------------
# Vend TFC JWT auth method in the namespace for TFC Workspace
#------------------------------------------------------------------------------

resource "vault_mount" "db" {
  path = var.vault_mount_path
  type = "database"
}

resource "vault_database_secret_backend_connection" "mysql" {
  backend       = vault_mount.db.path
  name          = var.connection_name

  allowed_roles = var.allowed_roles
  mysql {
    connection_url = "{{username}}:{{password}}@tcp(${var.db_url})/"

    username_template = "vault-user-{{.RoleName}}-{{(random 8)}}"
    # tls_ca = ""
    # tls_certificate_key =
    username = var.db_username
    password = var.db_password
    # max_connection_lifetime =
    # max_idle_connections =
    # max_open_connections =
  }
}


resource "vault_database_secret_backend_role" "mysql" {
  for_each = local.db_roles
  name    = each.value.role_name
  backend = vault_mount.db.path
  db_name = vault_database_secret_backend_connection.mysql.name

  creation_statements = [
    "CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';",
    "GRANT ALL PRIVILEGES ON `${each.value.database_name}`.* TO '{{name}}'@'%';"
  ]

  max_ttl = each.value.max_ttl
  default_ttl = each.value.default_ttl

}
