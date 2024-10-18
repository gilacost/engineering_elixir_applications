# in modules/integrations/github/project_management/.auto.tfvars

milestones = {
  "infrastructure" = {
    title       = "Infrastructure"
    due_date    = "2024-06-24"
    description = <<EOT
This milestone includes all the deliverables related to building the
application (e.g Dockerfile), provisioning AWS, the local environment
and the base AMI with Packer.
EOT
  },
  "ci-cd" = {
    title       = "Continuous Deployment / Continuous Integration"
    due_date    = "2024-06-24"
    description = <<EOT
This milestone will include all deliverables that have to do with GitHub
workflows that will perform the basic checks for an Elixir application.
It will also build the Docker image and pull the latest images in
production.
EOT
  },
  "instrumentation" = {
    title       = "Instrumentation"
    due_date    = "2024-07-01"
    description = <<EOT
This milestone will include all deliverables that have to do with the
addition of basic instrumentation and BEAM specific metrics for your
application. Any task(s) related to instrumentation (independently of
which part of the stack they relate to) will be included in this
milestone.
EOT
  },
  "documentation" = {
    title       = "Documentation"
    due_date    = ""
    description = <<EOT
This milestone includes documentation for Terraform, Elixir, Packer and
others and will converge with CI when needed.
EOT
  },
  "uncategorized" = {
    title       = "Uncategorized"
    due_date    = ""
    description = <<EOT
A milestone to add all issues that do not fit in any of the other
milestones. This is an easy way to track those uncategorized tasks.
EOT
  }
}
