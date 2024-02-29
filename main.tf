# https://sharmilas.me738215123dium.com/a-step-by-step-guide-to-creating-load-balancer-and-ec2-with-auto-scaling-group-using-terraform-752afd44df8e

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

}

provider "aws" {
  region  = "us-east-1"
}









