# tf-module-template

Template for creating terraform module repo.

## Needs

- Download all the linter dependencies
- Change the URL parameter in .github/workflows/cliff.toml with the repository URL so the commits can be shown on the CHANGELOG.md file

#### Pre-commit hook

The template utilizes [pre-commit](https://pre-commit.com/) hooks to run the linters before committing the code, if you are using starting the template for the first time, you need to enable the pre-commit, after that it will work for all subsecuents commits. To use the To install the pre-commit hooks run the following command:

```bash
pre-commit install
```

#### Hook Process

After that the pre-commit will check

- Terraform fmt
- Terraform tflint
- Terraform tfsec
- Terraform validate
- Terraform docs (if the tf-docs isn't updated the is going to overrite the README.md file)
- It will check for [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/)

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                     | Version  |
| ------------------------------------------------------------------------ | -------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.6.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm)       | 3.0.1    |

## Providers

| Name                                                         | Version |
| ------------------------------------------------------------ | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | 3.0.1   |

## Modules

No modules.

## Resources

| Name                                                                                                                               | Type     |
| ---------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [azurerm_resource_group.default_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.0.1/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

No outputs.

<!-- END_TF_DOCS -->
