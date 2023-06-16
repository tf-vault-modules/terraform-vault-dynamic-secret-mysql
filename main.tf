#------------------------------------------------------------------------------
# Vend TFC JWT auth method in the namespace for TFC Workspace
#------------------------------------------------------------------------------

resource "vault_mount" "db" {
  path = var.vault_mount_path
  type = "database"
}

resource "vault_database_secret_backend_connection" "this" {
  backend       = vault_mount.db.path
  name          = var.connection_name
  namespace = var.vault_namespace

  allowed_roles = var.allowed_roles

  mysql {
    connection_url = "{{username}}:{{password}}@tcp(${var.db_url})/"

    username_template = "vault-user-{{.RoleName}}-{{(random 8)}}"
    tls_ca = var.tls_ca
    tls_certificate_key =var.tls_certificate_key
    username = var.db_username
    password = var.db_password
    max_connection_lifetime = var.max_connection_lifetime
    max_idle_connections = var.max_idle_connections
    max_open_connections = var.max_open_connections
  }
}


resource "vault_database_secret_backend_role" "this" {
  for_each = local.db_roles
  name    = each.value.role_name
  backend = vault_mount.db.path

  db_name = vault_database_secret_backend_connection.this.name

  creation_statements = [
    "CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';",
    "GRANT ALL PRIVILEGES ON `${each.value.database_name}`.* TO '{{name}}'@'%';"
  ]

  max_ttl = each.value.max_ttl
  default_ttl = each.value.default_ttl

}

resource "vault_quota_rate_limit" "role" {
  for_each = {
    for key, item in local.db_roles : key => item
    if item.enable_quota
  }

  namespace = var.vault_namespace
  name = each.value.quota_path

  path = each.value.role_path

  rate = each.value.rate
  interval = each.value.interval
  block_interval = each.value.block_interval

  depends_on = [
    vault_database_secret_backend_connection.this,
    vault_database_secret_backend_role.this
  ]
}
