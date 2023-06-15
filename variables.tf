variable "roles" {

}

variable "connection_name" {
  default = "mysql"
}

variable "allowed_roles" {
  default = ["*"]
}

# db
variable "db_url" {
  description = "A URL containing connection information. See the Vault docs for an example."
}

variable "db_username" {
  description = "The database VAULT ADMIN username to authenticate with"
}

variable "db_password" {
  description = "The database VAULT ADMIN password to authenticate with"
}

variable "vault_namespace" {
  default = "root"
  description = "Vault Namespace"
}

variable "vault_mount_path" {
  description = "Vault Token display name"
}

variable "token_display_name" {
  default     = "dynamic-engine-vending-admin"
  description = "Vault Token display name"
}

variable "default_ttl" {
  default = 240
  type = number
  description = "Vault Namespace"
}

variable "default_max_ttl" {
  default = "600"
  type = number
  description = "Vault Namespace"
}
