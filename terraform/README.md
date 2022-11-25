# terraform

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.3.5 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | 2.23.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [digitalocean_app.tubenhirn-com](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/app) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ACCESS_TOKEN"></a> [ACCESS\_TOKEN](#input\_ACCESS\_TOKEN) | a access token | `string` | n/a | yes |
| <a name="input_APP_DOMAIN"></a> [APP\_DOMAIN](#input\_APP\_DOMAIN) | the name of the domain | `string` | n/a | yes |
| <a name="input_APP_DOMAIN_TYPE"></a> [APP\_DOMAIN\_TYPE](#input\_APP\_DOMAIN\_TYPE) | n/a | `string` | `"PRIMARY"` | no |
| <a name="input_APP_DOMAIN_ZONE"></a> [APP\_DOMAIN\_ZONE](#input\_APP\_DOMAIN\_ZONE) | n/a | `string` | n/a | yes |
| <a name="input_APP_NAME"></a> [APP\_NAME](#input\_APP\_NAME) | the name of the do app | `string` | n/a | yes |
| <a name="input_REGION"></a> [REGION](#input\_REGION) | the region | `string` | `"ams"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
