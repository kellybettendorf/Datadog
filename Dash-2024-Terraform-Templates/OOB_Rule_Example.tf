# See https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/security_monitoring_rule#detection_method for full list of options
# and https://github.com/DataDog/terraform-provider-datadog/blob/master/docs/resources/security_monitoring_default_rule.md
# Each Datadog-managed rule will need to be imported into the Terraform state file before tuning can be applied. Example import command:
# terraform import datadog_security_monitoring_default_rule.vvv-5pb-z59 vvv-5pb-z59
# The rule ID can be found in the URL when viewing the rule in Datadog.

# Please update the comment below to indicate the human-readable value of a rule ID
# Rule ID vvv-5pb-z59: "An AWS S3 bucket MFA delete is disabled"
resource "datadog_security_monitoring_default_rule" "vvv-5pb-z59" {
  enabled = false
}

# Change Log
# 5/23/2024: MFA delete protection was removed from all existing AWS S3 buckets as part of migration efforts.
