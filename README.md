# Engineering Elixir Applications: Source Code

This repository contains the source code for the chapters of [*Engineering Elixir Applications*](https://pragprog.com/titles/beamops/engineering-elixir-applications/). These materials are shared with permission from [PragProg](https://pragprog.com). 

<img src="images/book.jpg" width=25% />

The examples included are:

---

## **Preface and Introduction**
This code sets up the foundation for the journey, providing scripts to get started with the tools and concepts covered throughout the book.

- **[Preface](./preface)**
- **[Introduction to the Journey](./introduction_to_the_journey/)**: Scripts for initial setup.

---

## **Use Terraform to Create GitHub Issues and Milestones**
Automate GitHub repository setup using Terraform.

- **[Initial Setup](./use_terraform_to_create_github_issues_and_milestones/01_initial_setup)**: Create Terraform configurations.
- **[Milestones and Labels](./use_terraform_to_create_github_issues_and_milestones/05_labels)**: Automate GitHub workflows.

---

## **Build and Dockerize a Phoenix LiveView Application**
This chapter guides you through creating a Dockerized Phoenix LiveView application.

- **[FROM](./build_and_dockerize_a_phoenix_liveview_application/01_from)**: Start with a base image.
- **[ARGS](./build_and_dockerize_a_phoenix_liveview_application/02_args)**: Parameterize your Dockerfile.
- **[Compile Dependencies](./build_and_dockerize_a_phoenix_liveview_application/03_compile_deps)**: Set up your project dependencies.
- **[Release Configuration](./build_and_dockerize_a_phoenix_liveview_application/04_release_config)**: Configure for production releases.
- **[Mix Release](./build_and_dockerize_a_phoenix_liveview_application/05_mix_release)**: Build a release with Mix.
- **[Multi-Stage Builds](./build_and_dockerize_a_phoenix_liveview_application/06_multi_stage)**: Optimize the Docker build process.

---

## **Set Up Integration Pipelines with GitHub Actions**
Learn to create robust CI/CD pipelines using GitHub Actions.

- **[Failing Mix Compile](./set_up_integration_pipelines_with_github_actions/01_failing_mix_compile)**: Debugging initial failures.
- **[Successful Mix Compile](./set_up_integration_pipelines_with_github_actions/01_successful_mix_compile)**: Achieving a working build.
- **[Caching Dependencies](./set_up_integration_pipelines_with_github_actions/02_cache_deps_build)**: Speeding up builds with cache.
- **[Conditional Steps](./set_up_integration_pipelines_with_github_actions/03_conditional_steps)**: Making pipelines smarter.
- **[Triggers and Multi-Arch Builds](./set_up_integration_pipelines_with_github_actions/11_triggers)**: Expanding CI/CD capabilities.

---

## **The Development Environment and Docker Compose**
Set up a development environment with Docker Compose.

- **[Phoenix with Ecto](./the_dev_environment_and_docker_compose/01_phx_with_ecto)**: Add Ecto to your Phoenix app.
- **[Postgres Simple Setup](./the_dev_environment_and_docker_compose/02_postgres_simple)**: Configure Postgres.
- **[Adding Phoenix to Compose](./the_dev_environment_and_docker_compose/07_adding_your_phoenix_app)**: Integrate Phoenix into Docker Compose.

---

## **The Production Environment and Packer**
Move from development to production by using Packer to build machine images.

- **[EC2 Imports](./the_production_environment_and_packer/01_ec2_import_01)**: Set up your EC2 environment.
- **[Packer Introduction](./the_production_environment_and_packer/06_packer_intro)**: Build AMIs with Packer.
- **[Final Version](./the_production_environment_and_packer/08_final_version)**: Deploy a production-ready solution.

---

## **Continuous Deployment and Repository Secrets**
Securely manage secrets and automate deployments.

- **[Postgres Secrets](./continuous_deployment_and_repository_secrets/01_postgres_secret)**: Secure database credentials.
- **[Using SOPS](./continuous_deployment_and_repository_secrets/03_sops)**: Encrypt secrets in your repository.
- **[Deployment Workflow](./continuous_deployment_and_repository_secrets/07_deploy_action)**: Automate deployment actions.

---

## **Autoscaling and Optimizing Your Deployment Strategy**
This chapter shows how to create robust, scalable deployments with AWS.

- **[Autoscaling Groups](./autoscaling_and_optimizing_your_deployment_strategy/01_autoscaling_group_and_launch_template)**: Define autoscaling strategies.
- **[Trigger Autoscaling](./autoscaling_and_optimizing_your_deployment_strategy/04_trigger_auto_scaling)**: Monitor and adjust scaling policies.
- **[Load Balancers](./autoscaling_and_optimizing_your_deployment_strategy/05_load_balancer)**: Configure AWS load balancers.

---

## **Revise Your AWS Stack to Create a Multi-Node Swarm**
Build a highly available Docker Swarm using AWS.

- **[Multi-Node Swarm Setup](./revise_your_aws_stack_to_create_a_multinode_swarm/02_multinode_swarm)**: Provision a swarm cluster.
- **[Deployment Automation](./revise_your_aws_stack_to_create_a_multinode_swarm/05_initial_deployment_automation)**: Simplify cluster management.

---

## **Distributed Erlang**
Explore the power of distributed systems.

- **[Connect Releases](./distributed_erlang/01_connect_multiple_releases)**: Link multiple Elixir nodes.

---

## **Instrument Your Application with Logs and Metrics**
Learn to monitor your Elixir applications effectively.

- **[Add Logs](./instrument_your_application_with_logs_and_metrics/01_logs)**: Enhance observability with logs.
- **[Metrics with Promex](./instrument_your_application_with_logs_and_metrics/02_metrics_and_promex)**: Integrate Prometheus metrics.

---

## **Create a Custom Promex Metric and Grafana Alert**
Go beyond defaults to customize metrics and alerts.

- **[Custom Promex Plugin](./create_a_custom_promex_metric_and_grafana_alert/01_cpu_promex_plugin)**: Build a plugin for CPU metrics.
- **[Custom Alerts](./create_a_custom_promex_metric_and_grafana_alert/03_custom_alert)**: Define actionable Grafana alerts.
