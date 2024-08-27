<!-- markdownlint-disable MD033 -->
# AWS SSH KEY MODULE

Simple module to generate WALLIX cloud init data to be use with wallix Access Manager or Session Manager.

## Usage

```hcl
module "cloudinit-demo" {
  source    = "<path-to-module>"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [cloudinit_config.wallix_appliance](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_http_host_trusted_hostnames"></a> [http\_host\_trusted\_hostnames](#input\_http\_host\_trusted\_hostnames) | fqdn of the loadbalancers which will be added to http\_host\_trusted\_hostnames.<br> If muliple values, should be separated by a comma. | `string` | `""` | no |
| <a name="input_set_service_user_password"></a> [set\_service\_user\_password](#input\_set\_service\_user\_password) | Should we changepasswd for WALLIX Service user ?<br> ( Wabadmin, Wabsuper, Wabupgrade) | `bool` | `false` | no |
| <a name="input_to_base64_encode"></a> [to\_base64\_encode](#input\_to\_base64\_encode) | Should the user-data be encoded in base64? | `bool` | `false` | no |
| <a name="input_to_gzip"></a> [to\_gzip](#input\_to\_gzip) | Should the user-data be compressed ? | `bool` | `false` | no |
| <a name="input_use_of_lb"></a> [use\_of\_lb](#input\_use\_of\_lb) | Are you going to use a loadbalancer ? | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudinit_config"></a> [cloudinit\_config](#output\_cloudinit\_config) | The rendered user-data / cloud-init data |
| <a name="output_wallix_password_wabadmin"></a> [wallix\_password\_wabadmin](#output\_wallix\_password\_wabadmin) | Wabadmin password |
| <a name="output_wallix_password_wabsuper"></a> [wallix\_password\_wabsuper](#output\_wallix\_password\_wabsuper) | Wabsuper password |
| <a name="output_wallix_password_wabupgrade"></a> [wallix\_password\_wabupgrade](#output\_wallix\_password\_wabupgrade) | Wabupgrade password |
<!-- END_TF_DOCS -->