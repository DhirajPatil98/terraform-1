data "vault_kv_secret_v2" "example" {
  mount = "my_password"
  name  = "my_secret"
}



resource "aws_s3_bucket" "My_bucket" {
  
  bucket = "${data.vault_kv_secret_v2.example.data["password"]}-11898"
}