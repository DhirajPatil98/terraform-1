terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.32.1"
    }
  }

 backend "s3" {

    bucket = "myremotebackend11"
    key = "terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
   
 }
    
  
}