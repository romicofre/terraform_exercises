# Building infrastructure with terraform config 

## Files

**variables.tf**
Define environment variables as code variables. You can execute 
`terraform apply` and terraform will ask you by the values. Other way,
you can export environment variables as follows:

export TF_VAR_gcp_project=myproject
export TF_VAR_gcp_project=full_path/file.json

Terraform read environment variables with prefix TF_VAR_ as default.

Third way, create dev.tfvars.json file with the next content:

``` terraform
{
  "gcp_project": "my-project",
  "gcp_credentials": "full_path/file.json"
}
```