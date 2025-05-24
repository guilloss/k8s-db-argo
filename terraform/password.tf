resource "random_password" "argocd_admin_password" {
  length = 8
  special = false
  upper = true
  lower = true
  numeric = true
}

output "argocd_admin_password" {
  value       = random_password.argocd_admin_password.result
  description = "Mot de passe admin Argocd"
  sensitive = true
}