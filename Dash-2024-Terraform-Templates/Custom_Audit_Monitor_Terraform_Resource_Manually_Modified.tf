# Details on supported monitor options can be located at https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/monitor
resource "datadog_monitor" "Terraform_Managed_Detection_Rule_Manually_Modified_or_Deleted" {
  name               = "Terraform Managed Detection Rule Manually Modified or Deleted"
  type               = "audit alert"
  message            = <<EOF
## Goal: 
Identify instances where manual edits of Terraform-managed resources have occurred. This monitor triggers when changes are made to detection or suppression rules deployed 
by Terraform. If changes originate from Terraform and use the expected application key ID, the rule should not trigger. Notify @SecurityContact on alert.

## Triage/Response:
If this rule triggers, identify the source user and the change made. Audit logs will include a diff change showing the modified aspect of the rule.
Consider rolling back changes or disabling the user. If changes are part of planned work/testing, no further action is needed. However, the user should provide 
a copy of the associated ticket number or appropriate evidence for alert closure documentation.
Escalate as needed

## Change Log:  
Deployed on 5/23/2024
EOF
  escalation_message = "Manual modification of Terraform-managed resource @SecurityContact"
  # Query explanation:
  # - Look for audit events related to "Cloud Security Platform"
  # - Check for actions "deleted" or "modified"
  # - Check for actions "deleted" or "modified" where URL path contains "suppressions" 
  # - Exclude events triggered by Terraform (based on user agent and API key, could also add expected source IP)
  # - Roll up events by user email and count occurrences within the last 5 minutes

  query = "audits(\"(@evt.name:\\\"Cloud Security Platform\\\" @action:(deleted OR modified) (@asset.prev_value.tags:(\\\"source:custom\\\" \\\"source:terraform\\\") OR (@evt.name:\\\"Cloud Security Platform\\\" @action:(deleted OR modified) @http.url_details.path:*/suppressions/*))) -(@http.useragent:*terraform* @metadata.api_key.id:REPLACE-WITH-SERVICE-ACCOUNT-KEY-ID)\").rollup(\"count\").by(\"@usr.email\").last(\"5m\") >= 1"


  monitor_thresholds {
    critical = 1
  }

  include_tags = true
  tags         = ["source:custom", "team:security", "source:terraform"]
}
