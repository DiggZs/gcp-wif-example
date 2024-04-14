# GCP WIF Example

## Bootstrap

Export env variables

```bash
export PROJECT_ID="gg-flutter-app-dev" \
export PROJECT_NUMBER="244000224642" \
export REGION="us-central1" \
export WIF="github" \
export REPO="DiggZs/gcp-wif-example"
```

Authenticate with the gcloud CLI

```bash
gcloud auth login
gcloud config set project ${PROJECT_ID}
```

Make bootstrap file executable `chmod u+x .googlecloud/bootstrap.sh`

run [bootstrap](./.googlecloud/bootstrap.sh)


## Local Development

### Requirements

- Terraform v1.7.4
- Python 3.11 or later
- Google CLI


### Terraform

To run terraform plan locally after cloning the repository create the following file:


`provider_override.tf`

```HCL
terraform {
  backend "local" {
  }
}
```


Then run the following commands in your CLI:


```BASH
terraform init
terraform validate
terraform plan -var-file environments/dev.tfvars
```
