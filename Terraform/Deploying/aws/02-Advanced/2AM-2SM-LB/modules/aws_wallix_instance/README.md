<!-- markdownlint-disable MD033 -->
# Deployment module for Session Manager and Access Manager

Deploys one WALLIX Bastion or Access Manager instance from the Marketplace AMI or from the image shared by WALLIX, with its own network interface and an encrypted root volume.

## Usage

This minimal usage deploys a Bastion (default `product_name`) in the given subnet, from the latest image available on the Marketplace.

```hcl
module "instance_bastion" {
  source         =  "<path-to-module>"
  instance_name  =  "<name of the instance>"
  key_pair_name  =  "<name of AWS Key pair to use>"
  project_name   =  "<name of the project>"
  subnet_id      =  "<subnet id to use>"
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

## Resources

| Name | Type |
| ---- | ---- |
| [aws_instance.wallix](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_network_interface.wallix](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_ami.wallix-ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| instance\_name | Name of the instance | `string` | n/a | yes |
| key\_pair\_name | Name of the key pair that will be use to connect to the instance. | `string` | n/a | yes |
| project\_name | Name of the project. Will be used for Naming and Tags. | `string` | n/a | yes |
| subnet\_id | ID of the subnet to use for this instance | `string` | n/a | yes |
| ami-from-aws-marketplace | Should we use the marketplace image ? If false, the shared image by WALLIX will be use. | `bool` | `true` | no |
| ami-override | Force the usage of a specifique AMI-ID | `string` | `""` | no |
| aws\_instance\_size | Instance size to use. At least t3.xlarge recommended for production. | `string` | `"t2.medium"` | no |
| common\_tags | Map of tags to apply on instances resources. | `map(string)` | `{}` | no |
| disk\_size | Size of the root EBS volume, in GiB. Use at least 60 for production. | `number` | `40` | no |
| disk\_type | EBS disk type | `string` | `"gp3"` | no |
| product\_name | Specifies the product to deploy: bastion / access-manager | `string` | `"bastion"` | no |
| product\_version | Specifies the version of the bastion or access-manager.  It can be empty, partial or full value (5, 4.0 , 4.4.1, 4.4.1.8). Empty value will look for the latest pushed image. | `string` | `""` | no |
| user\_data | Content as cloud-init, plain text rendered or Base64 | `string` | `""` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| ami-info | Info regarding the AMI used. |
| instance | Full information of the instance. |
| instance-id | ID of the instance. |
| instance\_network\_interface\_id | ID of the network interface linked to the instance. |
| instance\_private\_ip | Private IP of the instance. |
<!-- END_TF_DOCS -->
