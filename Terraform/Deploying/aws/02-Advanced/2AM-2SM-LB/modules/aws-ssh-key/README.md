<!-- markdownlint-disable MD033 -->
# AWS SSH KEY MODULE

Simple module that will generate a new ssh key pair and push it to AWS.

Not suitable for production: the private key is stored in cleartext in the Terraform state.

## Usage

```hcl
module "demo" {
  source    = "<path-to-module>"
  key_name  = "whatever name you would like to pass for the ssh key."
}
```

The private key output can be written to a local file:

```hcl
resource "local_sensitive_file" "private_key" {
  content         = module.ssh_aws.ssh_private_key
  filename        = "private_key.pem"
  file_permission = "0400"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| aws | >= 5.0 |
| tls | >= 4.0 |

## Providers

| Name | Version |
| ---- | ------- |
| aws | >= 5.0 |
| tls | >= 4.0 |

## Resources

| Name | Type |
| ---- | ---- |
| [aws_key_pair.key_pair](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [tls_private_key.key_pair](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| key\_name | Name of the ssh Keypair which will be created on AWS | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| key\_pair\_name | Name of the ssh Keypair which was created on AWS. |
| ssh\_private\_key | The SSH Private key in openssh format. |
| ssh\_public\_key | The SSH public key in openssh format. |
<!-- END_TF_DOCS -->