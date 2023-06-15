locals {

  allowed_roles = [
    for item in var.roles : {
      vault_role_name      = "${item.role_name}-${item.database_name}"

    } if try(item.disabled, false) == true
  ]

  db_roles = ({
    for item in var.roles : "${coalesce(var.vault_namespace, "root")}/${coalesce(var.vault_mount_path, "database")}/${item.role_name}" => {
      database_name = item.database_name
      role_name = "${item.role_name}-${item.database_name}"
      role_path = "${coalesce(var.vault_mount_path, "approle")}/${item.role_name}"
      default_ttl = var.default_ttl
      max_ttl = var.default_max_ttl

      # quotas
      enable_quota = try(item.quota, true)
      quota_path = "${coalesce(var.vault_mount_path, "database")}-${item.role_name}"

      max_leases = try(item.quota.max_leases, var.default_max_leases)
      rate = try(item.quota.default_rate_limit_rate, var.default_rate_limit_rate)
      interval = try(item.quota.default_rate_limit_interval, var.default_rate_limit_interval)
      block_interval = try(item.quota.default_rate_limit_block_interval, var.default_rate_limit_block_interval)
    }
  })
}
