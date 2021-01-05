terraform {
  backend "s3" {
    endpoint                    = "https://s3.oswee.com"
    bucket                      = "terraform"
    key                         = "dev/terraform.tfstate"
    region                      = "eu-north-1"
    skip_requesting_account_id  = true
    skip_credentials_validation = true
    skip_get_ec2_platforms      = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    force_path_style            = true
  }
}

