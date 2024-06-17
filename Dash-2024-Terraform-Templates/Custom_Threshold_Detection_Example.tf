# See https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/security_monitoring_rule#detection_method for a full list of options
resource "datadog_security_monitoring_rule" "Dash2024_Custom_Threshold_Detection_Example" {
  name = "Dash 2024 Custom Threshold Detection Example"

  # For custom detections please include a short writeup about the rule,
  # including what the rule is for and triage and response recommendations in addition to adding an update to the change log.
  # Optionally include links to internal runbooks or escalation process
  message = <<EOF
##Goal:
Define a clear goal for the alert in one paragraph or less. Think about what you're trying to achieve with this alert. 
Is it catching a specific type of suspicious activity? Preventing a potential security threat? Make it short, sweet, and to the point!

##Triage/Response:
For the Triage steps, include initial actions to take when the alert fires. Add links to any internal tools or documents that might help with the investigation. 
If there have been similar incidents before, link to those investigations for reference.

For the Response steps, detail what actions should follow the triage. 
This could be figuring out who the manager or product/service owner is for the user or system that triggered the alert and escalating the issue to them. 
Think of it like a playbook for dealing with the alert.

##Change Log:
Whenever you make a change to the alert, jot down a brief comment and the date of the change. 
This keeps a neat and tidy history of whats been tweaked, when, and why.
EOF

  enabled = true

  query {
    name            = "a"
    query           = "source:* @evt.name:*"
    aggregation     = "count"
    group_by_fields = ["User Name"]
  }

  case {
    status    = "medium"
    condition = "a > 9"
    # If you would like a copy of detections to be emailed to you, add your DD username.
    # notifications = [""]
  }

  options {
    detection_method    = "threshold"
    evaluation_window   = 900   # Default is 15 min (900 seconds)
    keep_alive          = 3600  # Default is 1 hour (3600 seconds)
    max_signal_duration = 86400 # Default is 24 hours (86400 seconds)
  }

  # For custom alerts please use at least three tags, starting with one that indicates the source relevant to your detection and the second one indicating the rule is custom. 
  # For the last one, include "source:terraform". For example, tags = "source:aws", "source:custom", "source:terraform"
  tags = ["source:VALUE", "source:custom", "source:terraform"]
}
