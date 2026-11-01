terraform {
  // Cross-variable validation in modules/cloud-init-wallix requires Terraform 1.9.
  required_version = "~> 1.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 3.4"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

// Configure the AWS Provider
provider "aws" {
  region = var.aws-region
}

// Only used to display your egress IP (output your-public_ip), to help fill allowed_ips.
data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}

module "cloud-init-sm" {
  source                        = "./modules/cloud-init-wallix"
  set_service_user_password     = true
  use_of_lb                     = true
  http_host_trusted_hostnames   = aws_lb.front_sm.dns_name
  set_webui_password_and_crypto = true

}

module "cloud-init-am" {
  source                      = "./modules/cloud-init-wallix"
  use_of_lb                   = true
  set_service_user_password   = true
  http_host_trusted_hostnames = aws_lb.front_am.dns_name

}

module "ssh_aws" {
  source   = "./modules/aws-ssh-key"
  key_name = var.key_pair_name
}

// Written next to the configuration. *.pem is ignored by Git in this repository.
resource "local_sensitive_file" "private_key" {
  content         = module.ssh_aws.ssh_private_key
  filename        = "private_key.pem"
  file_permission = "0400"

}

// Contains cleartext secrets. info_replication.txt is ignored by Git in this repository.
resource "local_sensitive_file" "replication_master" {
  count           = var.number-of-sm == 2 ? 1 : 0
  filename        = "info_replication.txt"
  file_permission = "0600"
  content = templatefile("${path.module}/info_replication_master_master.tpl", {
    wabadmin_password  = module.cloud-init-sm.wallix_password_wabadmin,
    wabsuper_password  = module.cloud-init-sm.wallix_password_wabsuper,
    cryptokey_password = module.cloud-init-sm.wallix_crypto,
    webui_password     = module.cloud-init-sm.wallix_password_webui,
    ip1                = module.instance_bastion[0].instance_private_ip,
    ip2                = module.instance_bastion[1].instance_private_ip
    }
  )
}
