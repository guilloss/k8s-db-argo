resource "random_password" "argocd_admin_password" {
  length = 8
  special = false
  upper = true
  lower = true
  numeric = true
}

resource "bcrypt_hash" "argocd_admin_bcrypt_password" {
  password = random_password.argocd_admin_password
  cost     = 10
}

output "argocd_admin_password" {
  value       = random_password.argocd_admin_password.result
  description = "Mot de passe admin Argocd"
  sensitive = true
}