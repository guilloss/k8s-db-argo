server:
  extraArgs:
    - --insecure
global:
  domain: argocd.tp.oliv.info

configs:
  secret:
    argocdServerAdminPassword: "${argocd_admin_password.result}"
