#------------------------------------------------------------------------------
# To leverage more than one namespace, define a vault provider per namespace
#------------------------------------------------------------------------------
provider "vault" {
  token_name = var.token_display_name
  # address    = var.default_vault_address
  token = "root"
}
