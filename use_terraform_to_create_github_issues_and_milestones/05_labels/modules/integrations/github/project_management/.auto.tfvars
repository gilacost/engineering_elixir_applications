# START:labels
# in modules/integrations/github/project_management/.auto.tfvars

# END:labels

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

# START:labels
labels = {
  "kind-infrastructure" = {
    name  = "Kind:Infrastructure"
    color = "B60205"
  },
  "kind-ci-cd" = {
    name  = "Kind:CI-CD"
    color = "FBCA04"
  },
  "kind-instrumentation" = {
    name  = "Kind:Instrumentation"
    color = "0E8A16"
  },
  "kind-documentation" = {
    name  = "Kind:Documentation"
    color = "5319E7"
  },
  "kind-uncategorized" = {
    name  = "Kind:Uncategorized"
    color = "D93F0B"
  },
  "tech-docker" = {
    name  = "Tech:Docker"
    color = "1D76DB"
  },
  "dockerfile" = {
    name  = "Dockerfile"
    color = "3895AD"
  },
  "tech-elixir" = {
    name  = "Tech:Elixir"
    color = "D9B1FC"
  },
  "tech-gha" = {
    name  = "Tech:GHA"
    color = "66FE68"
  },
  "tech-docker-compose" = {
    name  = "Tech:Docker-Compose"
    color = "006B75"
  },
  "tech-packer" = {
    name  = "Tech:Packer"
    color = "1D76DB"
  },
  "tech-terraform" = {
    name  = "Tech:Terraform"
    color = "5319A1"
  },
  "tech-sops" = {
    name  = "Tech:SOPS"
    color = "F9D0C4"
  },
  "env-aws" = {
    name  = "Env:AWS"
    color = "D3A968"
  },
  "env-local" = {
    name  = "Env:Local"
    color = "0075ca"
  }
}
# END:labels