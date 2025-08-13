# backend.tf - local backend configuration (state stored locally)
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
