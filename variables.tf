variable "code_owner_squad" {
  description = "code_owner_squad to filter on, e.g. arch-bom"
  type        = string
}

variable "env" {
  description = "Environment to filter on, e.g. stg"
  type        = string
}

variable "recipients" {
  description = "Recipient mentions for paging and other notification, e.g. @opsgenie-My-Team-Datadog @slack-my-team"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Additional tags, as name:value pairs -- should include at least team:my-team"
  type        = list(string)
}

variable "apdex_add_request_filter" {
  description = "Additional trace query terms to filter on for apdex monitoring"
  type        = string
  default     = ""
}

variable "apdex_eval_period" {
  description = "Time window over which to evaluate apdex score"
  type        = string
  default     = "20m"
}

variable "apdex_threshold_millis" {
  description = "Maximum satisfactory response time, in milliseconds"
  type        = number
  default     = 300
}

variable "apdex_threshold_warning" {
  description = "Send warning alert when apdex score drops below this value"
  type        = number
  default     = 0.9
}

variable "apdex_threshold_critical" {
  description = "Send critical alert when apdex score drops below this value"
  type        = number
  default     = 0.8
}

variable "apdex_priority_warning" {
  description = "Priority level for when apdex drops below the warning threshold, e.g. 3 for P3"
  type        = number
  default     = 3
}

variable "apdex_priority_critical" {
  description = "Priority level for when apdex drops below the critical threshold, e.g. 2 for P2"
  type        = number
  default     = 2
}

variable "apdex_add_message" {
  description = "Additional information to add to the apdex alert messages."
  type        = string
  default     = ""
}
