# https://registry.terraform.io/providers/DataDog/datadog/latest/docs
# Terraform 0.13+ uses the Terraform Registry:
terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

# Configure the Datadog provider
provider "datadog" {
  # Avoid hardcoded keys. Use variables and secure storage location
  # A step-by-step guide for locally running terraform can be found at https://developer.hashicorp.com/terraform/tutorials/use-case/datadog-provider
  api_key = ""
  app_key = ""
  # The API URL is optional, and based on the Datadog region you are using
  # Specify a custom URL only if required for your environment
  # More details on Datadog regions: https://docs.datadoghq.com/getting_started/site/
  api_url = "https://api.us5.datadoghq.com/"
}