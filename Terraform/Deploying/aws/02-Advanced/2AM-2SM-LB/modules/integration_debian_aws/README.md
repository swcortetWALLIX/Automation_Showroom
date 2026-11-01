<!-- markdownlint-disable MD033 -->
# Debian integration host

A terraform module to provide an integration jumphost for WALLIX integrators for resources in AWS environment.
The idea is to give third parties access to WALLIX targets without giving them any access to the AWS account.

## Usage example

```hcl
module "integration_debian" {
  count             = var.deploy-integration-debian ? 1 : 0
  source            = "./modules/integration_debian_aws"
  tags              = local.common_tags
  sm-instances      = local.sm_instances
  project_name      = local.project_name
  allowed_ips       = var.allowed_ips
  subnet_id         = aws_subnet.subnet_az_AM[0].id
  aws_instance_size = var.aws_instance_size_debian
  common_tags       = local.common_tags
  vpc_id            = aws_vpc.cluster.id
  key_pair_name     = module.ssh_aws.key_pair_name
  private_key       = module.ssh_aws.ssh_private_key
  public_ssh_key    = module.ssh_aws.ssh_public_key

}
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| aws | >= 6.0 |

## Providers

| Name | Version |
| ---- | ------- |
| aws | >= 6.0 |
| cloudinit | n/a |
| random | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [aws_eip.public_ip_debian](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_instance.debian_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_network_interface.debian-linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_security_group.debian_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [random_password.password_rdpuser](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_ami.debian-linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [cloudinit_config.integration_debian](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| key\_pair\_name | Name of the key pair that will be use to connect to the instance. | `string` | n/a | yes |
| private\_key | Private key to be added in /home/admin/.ssh/ to connect to WALLIX Instances. | `string` | n/a | yes |
| project\_name | Name of the project. Will be used for Naming and Tags. | `string` | n/a | yes |
| public\_ssh\_key | Public key to be added in /home/rdpuser/.ssh/authorized\_keys. | `string` | n/a | yes |
| sm-instances | list of SM IP or Network in CIDR Format. | `list(string)` | n/a | yes |
| subnet\_id | ID of the subnet to use for this instance | `string` | n/a | yes |
| vpc\_id | vpc\_id to which attach the security group | `string` | n/a | yes |
| allowed\_ips | CIDR blocks allowed to reach the integration instance (SSH, RDP), e.g. ["203.0.113.10/32"]. | `list(string)` | ```[ "127.0.0.1/32" ]``` | no |
| aws\_instance\_size | Specifies the instance sizing. | `string` | `"t3.medium"` | no |
| common\_tags | Map of tags to apply on instances resources. | `map(string)` | `{}` | no |
| debian\_version | version debian to use. 11, 12. | `number` | `12` | no |
| tags | Map of tags to apply on instances resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| cloudinit\_config | Rendered cloud-init (contains the rdpuser password and the private key). For debugging. |
| password\_rdpuser | Generated password for rdp connexion with rdpuser. |
| private\_ip\_debian\_admin | Private IP of the debian instance. |
| public\_ip\_debian\_admin | Public IP of the debian instance. |
| z\_connect | How to connect to instance. |
<!-- END_TF_DOCS -->