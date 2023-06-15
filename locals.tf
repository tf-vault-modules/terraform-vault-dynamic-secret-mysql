locals {

  allowed_roles = [
    for item in var.roles : {
      vault_role_name      = "${item.role_name}-${item.database_name}"

    } if try(item.disabled, false) == true
  ]

  db_roles = ({
    for item in var.roles : "${coalesce(var.vault_namespace, "root")}/${coalesce(var.vault_mount_path, "tfc")}/${item.role_name}" => {
      database_name = item.database_name
      role_name = "${item.role_name}-${item.database_name}"
      default_ttl = var.default_ttl
      max_ttl = var.default_max_ttl
    }
  })
}
