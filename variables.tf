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

variable "tls_ca" {
  default = ""
  type = string
  description = "x509 CA file for validating the certificate presented by the MySQL server. Must be PEM encoded."
}

variable "tls_certificate_key" {
  default = ""
  type = string
  description = "x509 certificate for connecting to the database. This must be a PEM encoded version of the private key and the certificate combined"
}

variable "username_template" {
  default = ""
  type = string
  description = "For Vault v1.7+. The template to use for username generation. See the Vault docs"
}
variable "max_connection_lifetime" {
  default = null
  type = number
  description = "The maximum number of seconds to keep a connection alive for."
}

variable "max_idle_connections" {
  default = null
  type = number
  description = "The maximum number of idle connections to maintain."
}

variable "max_open_connections" {
  default = null
  type = number
  description = "The maximum number of open connections to use."
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

variable "lease_count_enabled" {
  default     = false
  type = bool
  description = "ENTERPRISE ONLY! Manage lease count quotas which enforce the number of leases that can be created. \nA lease count quota can be created at the root level or defined on a namespace or mount by specifying a path when creating the quota"
}

variable "default_creation_statements" {
  default = [
    "CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';",
    "GRANT SELECT ON *.* TO '{{name}}'@'%';"
  ]
  type = list(string)
  description = "SQL Statements to be executed for creation"
}

variable "default_revocation_statements" {
  default = null
  type = list(string)
  description = "SQL Statements to be executed for revocation"
}

variable "default_renew_statements" {
  default = null
  type = list(string)
  description = "SQL Statements to be executed for renew"
}

variable "default_rollback_statements" {
  default = null
  type = list(string)
  description = "SQL Statements to be executed for rollback"
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


variable "default_max_leases" {
  default = "100"
  type = number
  description = "The maximum number of leases to be allowed by the quota rule. The max_leases must be positive."
}

variable "default_rate_limit_rate" {
  default = "10"
  type = number
  description = "The maximum number of requests at any given second to be allowed by the quota rule. The rate must be positive."
}

variable "default_rate_limit_interval" {
  default = "1"
  type = number
  description = "The duration in seconds to enforce rate limiting for"
}

variable "default_rate_limit_block_interval" {
  default = "10"
  type = number
  description = "If set, when a client reaches a rate limit threshold, the client will be prohibited from any further requests until after the 'block_interval' in seconds has elapsed."
}
