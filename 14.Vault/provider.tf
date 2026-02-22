provider "aws" {
  region = "us-east-1"
}



  provider "vault" {
  address = "http://44.198.182.118:8200"

  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id   = "d7ad76f1-c2ad-4a45-c7f5-56dae738124a"
      secret_id = "e67de6d0-3140-0f68-07d2-fff4bfe0b75a"
    }
  }

  
}