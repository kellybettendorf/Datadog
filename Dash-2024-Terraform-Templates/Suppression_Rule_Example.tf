resource "datadog_security_monitoring_suppression" "Dash_2024_Example_Suppression_Rule" {
  # Name and description will be seen in Datadog UI
  name = "Dash 2024 Example Suppression Rule"
  # Note: Our description section does not include a Triage/Response section, as it's not relevant for a suppression rule
  description = <<EOF
## Goal: 
Suppress alerts from test environments.

## Change Log:
Deployed on 5/25/2024
EOF
  enabled     = true
  # To ensure best results, it's recommended that you use a rule_query based on detection rule IDs.
  # By not using explicit rule IDs, you open the possibility of unintentionally including more rules than intended. 
  # For example, if a new rule is created and the creator of that rule is not aware of the suppression rules logic, 
  # it could be included by existing suppression logic.
  rule_query        = "ruleId:(def-000-tvg OR def-000-zt4 OR def-000-69d)"
  suppression_query = "env:test source:cloudtrail"
  # Expiration date is optional. If the suppression rule should live indefinitely, leave it commented out.
  # expiration_date   = ""
}
