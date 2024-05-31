locals {
  # Span filter for LMS Django requests that match the configuration of this module
  lms_django_request = "@_top_level:1 service:edx-edxapp-lms operation_name:django.request env:${var.env} @code_owner_squad:\"${var.code_owner_squad}\""

  apdex_trace_query = "${local.lms_django_request} ${var.apdex_additional_request_filter}"

  # Span filter for requests that are "satisfied" according to the apdex threshold
  apdex_satisfied = "status:ok @duration:[0ms TO ${var.apdex_threshold_millis}ms]"

  # Span filter for requests that are "tolerated" according to the apdex threshold
  apdex_tolerated = "status:ok @duration:[${var.apdex_threshold_millis + 1}ms TO ${var.apdex_threshold_millis * 4}ms]"
}

resource "datadog_monitor" "low_apdex_monitor" {
  name = "Low apdex in ${var.env} edxapp-lms (for ${var.code_owner_squad} squad)"
  type = "trace-analytics alert"

  message = <<EOMESSAGE
    {{#is_alert}}
      Low apdex in ${var.env} edxapp-lms for code owned by the ${var.code_owner_squad} squad.
      This can indicate elevated error rates and/or response times.
      ${var.apdex_additional_message}
    {{#is_alert}}

    ${var.recipients}

    {{#is_warning}}{{override_priority 'P${var.apdex_priority_warning}'}}{{/is_warning}}
EOMESSAGE

  # apdex: (satisfied + tolerated/2) / all
  query = <<EOQUERY
    trace-analytics("
      (
        count[${local.apdex_trace_query} ${local.apdex_satisfied}]
        +
        count[${local.apdex_trace_query} ${local.apdex_tolerated}] / 2
      )
      /
      count[${local.apdex_trace_query}]
    ").last("${var.apdex_eval_period}") < ${var.apdex_threshold_critical}
EOQUERY

  monitor_thresholds {
    critical = var.apdex_threshold_critical
    warning  = var.apdex_threshold_warning
  }

  include_tags      = false
  notify_no_data    = false
  notify_audit      = false
  renotify_interval = 0
  timeout_h         = 0
  new_group_delay   = 0
  priority          = var.apdex_priority_critical

  tags = concat(["env:${var.env}", "service:edx-edxapp-lms", "team:${var.team_tag}", "terraform-managed"], var.additional_tags)
}
