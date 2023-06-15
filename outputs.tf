output "namespace" {
  value       = var.vault_namespace
  description = "Vault namespace"
}

output "backend" {
  value       = ""
  description = "Vault Dynamic Secret Engine"
}

output "roles" {
  value       = local.db_roles
  description = "Dynamic Secret Role"
}

output "allowed_roles" {
  value       = local.allowed_roles
  description = "Dynamic Secret Role"
}
