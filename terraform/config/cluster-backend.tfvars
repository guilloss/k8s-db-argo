bucket = "k8s-database-terraform"
key = "k8s-database.tfstate"
region = "fr-par"
endpoints = { 
  s3 = "https://s3.fr-par.scw.cloud"
}
skip_credentials_validation = true
skip_region_validation = true
skip_requesting_account_id = true
access_key = var.SCW_ACCESS_KEY
secret_key = var.SCW_SECRET_KEY
