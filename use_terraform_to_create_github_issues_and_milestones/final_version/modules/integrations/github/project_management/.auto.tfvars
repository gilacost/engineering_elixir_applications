# in modules/integrations/github/project_management/.auto.tfvars

milestones = {
  "infrastructure" = {
    title       = "Infrastructure"
    due_date    = "2024-06-24"
    description = <<EOT
This milestone includes all the deliverables related to building the
application (e.g Dockerfile), provisioning AWS, the local environment and
the base AMI with Packer.
EOT
  },
  "ci-cd" = {
    title       = "Continuous Deployment / Continuous Integration"
    due_date    = "2024-06-24"
    description = <<EOT
This milestone will include all deliverables that have to do with GitHub
workflows that will perform the basic checks for an Elixir application. It
will also build the Docker image and pull the latest images in production.
EOT
  },
  "instrumentation" = {
    title       = "Instrumentation"
    due_date    = "2024-07-01"
    description = <<EOT
This milestone will include all deliverables that have to do with the
addition of basic instrumentation and BEAM specific metrics for your
application. Any task(s) related to instrumentation (independently of which
part of the stack they relate to) will be included in this milestone.
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
milestones. This is a way to track those uncategorized tasks in an easy way.
EOT
  }
}

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

issues = [
  {
    title     = "Implement the Dockerfile's builder stage"
    body      = <<EOT
The builder stage packages all the tools and compile-time dependencies for
your application. It has to build the mix release that will be copied in the
running stage.
EOT
    labels    = ["kind-infrastructure", "dockerfile"]
    milestone = "infrastructure"
  },
  {
    title     = "Implement the Dockerfile's runner stage"
    body      = <<EOT
This stage copies the release built in the builder stage and uses it as the
entrypoint of your Docker image with the minimum system requirement to run
it.
EOT
    labels    = ["kind-infrastructure", "dockerfile"]
    milestone = "infrastructure"
  },
  {
    title     = "Elixir integration pipelines"
    body      = <<EOT
Implement a CI pipeline that includes all of the necessary steps when
delivering an Elixir application: code compilation, dependency caching,
testing, code formatting, an unused dependency check.
EOT
    labels    = ["kind-ci-cd", "tech-elixir"]
    milestone = "ci-cd"
  },
  {
    title     = "Push Docker image to GitHub registry automatically"
    body      = <<EOT
Automate the pushing of your Docker image to the GitHub Docker registry if
your CI pipeline passes. You will need to authenticate yourself with the
registry before being able to push. You should create three tags for your
Docker image: one that matches the commit it refers to, one that matches the
pull request number (if present), and other that is "latest".
EOT
    labels    = ["kind-ci-cd", "tech-docker"]
    milestone = "ci-cd"
  },
  {
    title     = "Create a Docker Compose file"
    body      = <<EOT
Create a Docker Compose file that includes a PostgreSQL database and your
Phoenix Live View application.
EOT
    labels    = ["kind-infrastructure", "tech-docker-compose", "env-local"]
    milestone = "infrastructure"
  },
  {
    title     = "Create production env in AWS for a single-node swarm"
    body      = <<EOT
Add all of the AWS resources that will allow you to deploy your application
to a remote single-node swarm to your Terraform configuration. (Making the
resources support a multi-node swarm will be in another task). You need to
add an EC2 instance, a VPC, a security group, SSH key pair.
EOT
    labels    = ["kind-infrastructure", "tech-terraform", "env-aws"]
    milestone = "infrastructure"
  },
  {
    title     = "Create the EC2 AMI"
    body      = <<EOT
Use Packer to create a custom AMI (Amazon Machine Image) for your EC2
instances and then link it to your existing AWS Terraform infrastructure.
This AMI should pre-install Docker and netcat.
EOT
    labels    = ["kind-infrastructure", "tech-packer", "env-aws"]
    milestone = "infrastructure"
  },
  {
    title     = "Create a Continuous Deployment pipeline"
    body      = <<EOT
Add a new GitHub action to your CI/CD pipeline that automatically deploys
your Phoenix Live View application any time any code is merged into the main
branch of your repository. This action should use the build tags that are
created in the CI pipeline.
EOT
    labels    = ["kind-ci-cd", "tech-gha", "tech-sops"]
    milestone = "ci-cd"
  },
  {
    title     = "Hide any sensitive data using Docker secrets"
    body      = <<EOT
Use Docker secrets to hide the values to the following variables in your
Docker Compose file: DATABASE_URL, POSTGRES_PASSWORD, and SECRET_KEY_BASE.
EOT
    labels    = ["kind-ci-cd", "tech-gha", "tech-sops"]
    milestone = "ci-cd"
  },
  {
    title     = "Update Terraform Configuration for a multi-node swarm"
    body      = <<EOT
Revise your Terraform configuration so that it can support a multi-node
swarm. To do this, create more than one EC2 instance and distribute it
across 3 availibility zones.
EOT
    labels    = ["kind-infrastructure", "tech-terraform", "env-aws"]
    milestone = "infrastructure"
  },
  {
    title     = "Make Elixir app part of a Distributed Erlang cluster"
    body      = <<EOT
Make the different instances of your Phoenix Live View Application form part
of a distributed Erlang cluster. Do this using the libcluster library after
you start the application as an Erlang node.
EOT
    labels    = ["kind-infrastructure", "tech-elixir"]
    milestone = "infrastructure"
  },
  {
    title     = "Make the Elixir application autoscale"
    body      = <<EOT
Adapt your AWS Terraform configuration to use an Auto Scaling Group so that
your Elixir application scales up/down depending on the average CPU usage of
the EC2 intances in that group.
EOT
    labels    = ["kind-infrastructure", "tech-terraform", "env-aws"]
    milestone = "infrastructure"
  },
  {
    title     = "Implement automatic rollback upon failed deployments"
    body      = <<EOT
Update the deployment keys of your Phoenix Live View application so that
it automatically rolls back to a previous version if the image you want
to deploy does not start properly.
EOT
    labels    = ["kind-infrastructure", "tech-docker"]
    milestone = "infrastructure"
  },
  {
    title     = "Implement Basic Instrumentation"
    body      = <<EOT
Use Loki and Promtail to collect the logs for your Docker containers and
Grafana to display them. Then use Prometheus and PromEx to collect the
metrics exposed by the main libraries used in an Elixir application.
EOT
    labels    = ["kind-instrumentation", "tech-docker", "tech-elixir"]
    milestone = "instrumentation"
  },
  {
    title     = "Create Your Own Custom PromEx Metric"
    body      = <<EOT
Create your own custom PromEx metric that monitors the CPU usage of your
Elixir application.
EOT
    labels    = ["kind-instrumentation", "tech-elixir"]
    milestone = "instrumentation"
  },
  {
    title     = "Create A CPU Alert For Your Application"
    body      = <<EOT
Create an alert so that you are notified any time the average CPU of your
Elixir applications reaches above 50%.
EOT
    labels    = ["kind-instrumentation", "tech-elixir"]
    milestone = "instrumentation"
  }
]
