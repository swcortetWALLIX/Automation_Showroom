<!-- markdownlint-disable MD033 -->
# CLOUD-INIT MODULE

Simple module to generate WALLIX cloud init data to be use with wallix Access Manager or Session Manager.

## Usage

```hcl
module "cloudinit-demo" {
  source    = "<path-to-module>"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| terraform | >= 1.9 |

## Providers

| Name | Version |
| ---- | ------- |
| cloudinit | n/a |
| random | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [random_password.cryptokey_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.webui_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [cloudinit_config.wallix_appliance](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| http\_host\_trusted\_hostnames | FQDN of the load balancers to add to http\_host\_trusted\_hostnames, comma separated. Required when use\_of\_lb is true. | `string` | `""` | no |
| set\_service\_user\_password | Set generated passwords for the WALLIX service accounts (wabadmin, wabsuper, wabupgrade). | `bool` | `false` | no |
| set\_webui\_password\_and\_crypto | Bastion (Session Manager) only: set a generated web UI admin password and a generated encryption passphrase. | `bool` | `false` | no |
| to\_base64\_encode | Should the user-data be encoded in base64? | `bool` | `false` | no |
| to\_gzip | Should the user-data be compressed ? | `bool` | `false` | no |
| use\_of\_lb | Configure the appliance to be served behind a load balancer. | `bool` | `false` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| cloudinit\_config | The rendered user-data / cloud-init data |
| wallix\_crypto | Cryptokey |
| wallix\_password\_wabadmin | Wabadmin password |
| wallix\_password\_wabsuper | Wabsuper password |
| wallix\_password\_wabupgrade | Wabupgrade password |
| wallix\_password\_webui | Webui Admin password |
<!-- END_TF_DOCS -->