server:
  extraArgs:
    - --insecure
global:
  domain: argocd.tp.oliv.info
configs:
  secret:
    argocdServerAdminPassword: "${bcrypt_hash.argocd_admin_bcrypt_password.hash}"