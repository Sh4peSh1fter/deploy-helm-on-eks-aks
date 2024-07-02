terraform {
    required_version = ">= 1.1.0"

    required_providers {
        aws = {
          source = "hashicorp/aws"
          version = "5.56.1"
        }
        helm = {
            source = "hashicorp/helm"
            version = "2.14.0"
        }
    }
}

provider "aws" {
  region  = var.location
}

provider "helm" {
  kubernetes {
    
  }
}