output "namespace" {
  value       = module.vault_dynamic_secret_mysql.namespace
  description = "Vault namespace"
}

output "backend" {
  value       = module.vault_dynamic_secret_mysql.backend
  description = "Vault Dynamic Secret Engine"
}

output "roles" {
  value       = module.vault_dynamic_secret_mysql.roles
  description = "Dynamic Secret Role"
}

output "allowed_roles" {
  value       = module.vault_dynamic_secret_mysql.allowed_roles
  description = "Dynamic Secret Role"
}
