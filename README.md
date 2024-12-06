# Engineering Elixir Applications: Source Code

This repository contains the source code for [*Engineering Elixir Applications*](https://pragprog.com/titles/beamops/engineering-elixir-applications/) by Ellie and Pep. The book is published by Pragmatic Bookshelf.

<img src="images/cover.jpg" width=25% />

The source code is separated into the 12 different chapters of the book. The code in each chapter is further divided into the different sections/themes. The chapters have been structured as follows:

---

## **01-Introduction**
This code sets up the foundation for the journey, providing scripts to get started with the tools and concepts covered throughout the book.

- **[Introduction to the Journey](./introduction_to_the_journey)**: Scripts for initial setup. *(pp. 1-12)*

---

## **02-Use Terraform to Create GitHub Issues and Milestones**
Automate GitHub repository setup using Terraform.

- **[Initial Setup](./use_terraform_to_create_github_issues_and_milestones/01_initial_setup)** *(pp. 13-25)*
- **[Local Values](./use_terraform_to_create_github_issues_and_milestones/02_local_values)** *(pp. 26-28)*
- **[Initial Milestones Setup](./use_terraform_to_create_github_issues_and_milestones/03_initial_milestones_setup)** *(pp. 29-30)*
- **[Milestones with Variables](./use_terraform_to_create_github_issues_and_milestones/04_milestones_with_variables)** *(pp. 31-37)*
- **[Labels](./use_terraform_to_create_github_issues_and_milestones/05_labels)** *(pp. 38-42)*
- **[Resource Dependencies](./use_terraform_to_create_github_issues_and_milestones/06_resource_dependencies)** *(p. 43)*
- **[Issues](./use_terraform_to_create_github_issues_and_milestones/07_issues)** *(pp. 44-48)*
- **[Extra Mile](./use_terraform_to_create_github_issues_and_milestones/08_extra_mile)**
- **[Final Version](./use_terraform_to_create_github_issues_and_milestones/final_version)**

---

## **03-Build and Dockerize a Phoenix LiveView Application**
This chapter guides you through creating a Dockerized Phoenix LiveView application.

- **[FROM](./build_and_dockerize_a_phoenix_liveview_application/01_from)** *(pp. 49-63)*
- **[ARGS](./build_and_dockerize_a_phoenix_liveview_application/02_args)** *(pp. 64-66)*
- **[Compile Dependencies](./build_and_dockerize_a_phoenix_liveview_application/03_compile_deps)** *(pp. 67-69)*
- **[Release Configuration](./build_and_dockerize_a_phoenix_liveview_application/04_release_config)** *(p. 70)*
- **[Mix Release](./build_and_dockerize_a_phoenix_liveview_application/05_mix_release)** *(pp. 71-73)*
- **[Multi-Stage Builds](./build_and_dockerize_a_phoenix_liveview_application/06_multi_stage)** *(pp. 74-78)*

---

## **04-Set Up Integration Pipelines with GitHub Actions**
Learn to create robust CI/CD pipelines using GitHub Actions.

- **[Failing Mix Compile](./set_up_integration_pipelines_with_github_actions/01_failing_mix_compile)** *(pp. 79-81)*
- **[Successful Mix Compile](./set_up_integration_pipelines_with_github_actions/01_successful_mix_compile)** *(pp. 82-87)*
- **[Caching Dependencies](./set_up_integration_pipelines_with_github_actions/02_cache_deps_build)** *(pp. 88-91)*
- **[Conditional Steps](./set_up_integration_pipelines_with_github_actions/03_conditional_steps)** *(pp. 92-93)*
- **[Failing Mix Test](./set_up_integration_pipelines_with_github_actions/04_failing_mix_test)** *(pp. 94-95)*
- **[Successful Mix Test](./set_up_integration_pipelines_with_github_actions/04_successful_mix_test)**
- **[Failing Mix Format](./set_up_integration_pipelines_with_github_actions/05_failing_mix_format)** *(p. 96)*
- **[Successful Mix Format](./set_up_integration_pipelines_with_github_actions/05_successful_mix_format)** *(p. 97)*
- **[Failing Dialyzer](./set_up_integration_pipelines_with_github_actions/06_failing_dialyzer)** *(pp. 98-99)*
- **[Successful Dialyzer](./set_up_integration_pipelines_with_github_actions/06_successful_dialyzer)** *(pp. 100-101)*
- **[Unused Dependencies](./set_up_integration_pipelines_with_github_actions/07_unused_dependencies)** *(pp. 102-105)*
- **[Build Docker](./set_up_integration_pipelines_with_github_actions/08_build_docker)** *(pp. 106-109)*
- **[Cache Docker Build](./set_up_integration_pipelines_with_github_actions/09_cache_docker_build)** *(pp. 110-112)*
- **[Multi-Arch Builds](./set_up_integration_pipelines_with_github_actions/10_multi_arch)** *(pp. 113-115)*
- **[Triggers](./set_up_integration_pipelines_with_github_actions/11_triggers)** *(pp. 116-118)*
- **[Extra Mile](./set_up_integration_pipelines_with_github_actions/12_extra_mile)**

---

## **05-The Development Environment and Docker Compose**
Set up a development environment with Docker Compose.

- **[Installing Phoenix with Ecto](./the_dev_environment_and_docker_compose/01_phx_with_ecto)** *(pp. 119-134)*
- **[Simple Postgres Setup](./the_dev_environment_and_docker_compose/02_postgres_simple)** *(pp. 135-136)*
- **[Postgres Ports Published (Hardcoded)](./the_dev_environment_and_docker_compose/03_postgres_ports_published_hardcoded)** *(pp. 137-138)*
- **[Postgres Ports Published](./the_dev_environment_and_docker_compose/04_postgres_ports_published)**
- **[Postgres Pinned Version](./the_dev_environment_and_docker_compose/05_postgres_pinned_version)** *(pp. 139-141)*
- **[Postgres with Explicit Volume definition](./the_dev_environment_and_docker_compose/06_postgres_explicit_volume)** *(pp. 142-144)*
- **[Adding Phoenix to Compose](./the_dev_environment_and_docker_compose/07_adding_your_phoenix_app)** *(pp. 145-147)*
- **[Updating Your CI Pipeline](./the_dev_environment_and_docker_compose/08_update_your_ci_pipeline)** *(pp. 148-156)*
- **[Extra Mile](./the_dev_environment_and_docker_compose/09_extra_mile)**

---

## **06-The Production Environment and Packer**
This chapter shows how to set up a robust production environment using Packer to build machine images.

- **[EC2 Import - Part 1](./the_production_environment_and_packer/01_ec2_import_01)** *(pp. 157-172)*
- **[EC2 Import - Part 2](./the_production_environment_and_packer/01_ec2_import_02)** *(p. 173)*
- **[EC2 Import - Part 3](./the_production_environment_and_packer/01_ec2_import_03)** *(pp. 174-175)*
- **[EC2 Import - Part 4](./the_production_environment_and_packer/01_ec2_import_04)** *(p. 176)*
- **[SG Import - Part 1](./the_production_environment_and_packer/02_sg_import_01)** *(pp. 177-180)*
- **[SG Import - Part 2](./the_production_environment_and_packer/02_sg_import_02)** *(p. 181)*
- **[VPC and Subnet Config](./the_production_environment_and_packer/03_vpc_and_subnet_config)** *(pp. 182-183)*
- **[Key Pair Import](./the_production_environment_and_packer/04_key_pair_import)** *(pp. 184-189)*
- **[Bootstrap EC2](./the_production_environment_and_packer/05_boostrap_ec2)**  *(pp. 190-191)*
- **[Packer Introduction](./the_production_environment_and_packer/06_packer_intro)** *(pp. 192-196)*
- **[Packer Refactor](./the_production_environment_and_packer/07_packer_refactor)** *(pp. 197-200)*
- **[Final Version](./the_production_environment_and_packer/08_final_version)** *(pp. 201-208)*
- **[Extra Mile](./the_production_environment_and_packer/09_extra_mile)**

---

## **07-Continuous Deployment and Repository Secrets**
Learn to securely manage repository secrets and automate deployments.

- **[Postgres Secret](./continuous_deployment_and_repository_secrets/01_postgres_secret)** *(pp. 209-213)*
- **[Web Secrets - Part 1](./continuous_deployment_and_repository_secrets/02_web_secrets_01)** *(pp. 214-218)*
- **[Web Secrets - Part 2](./continuous_deployment_and_repository_secrets/02_web_secrets_02)** *(pp. 219-221)*
- **[SOPS](./continuous_deployment_and_repository_secrets/03_sops)** *(pp. 222-229)*
- **[Secrets Decrypt Script](./continuous_deployment_and_repository_secrets/04_secrets_decrypt_script)** *(pp. 230-231)*
- **[Convenience Script](./continuous_deployment_and_repository_secrets/05_convenience_script)** *(pp. 232-236)*
- **[GitHub Secrets](./continuous_deployment_and_repository_secrets/06_github_secrets)** *(pp. 237-241)*
- **[Deployment Action](./continuous_deployment_and_repository_secrets/07_deploy_action)** *(pp. 242-246)*
- **[Contributing Workflow](./continuous_deployment_and_repository_secrets/08_contributing_workflow)** *(pp. 247-250)*
- **[Extra Mile](./continuous_deployment_and_repository_secrets/09_extra_mile)**

---

## **08-Revise Your AWS Stack to Create a Multi-Node Swarm**
Build a highly available Docker Swarm using AWS.

- **[Multiple EC2 Instances](./revise_your_aws_stack_to_create_a_multinode_swarm/01_multiple_ec2_instances)** *(pp. 251-254)*
- **[Multi-Node Swarm](./revise_your_aws_stack_to_create_a_multinode_swarm/02_multinode_swarm)** *(pp. 255-266)*
- **[Initialize Script](./revise_your_aws_stack_to_create_a_multinode_swarm/03_initialize_script)** *(pp. 267-272)*
- **[Join Script - Part 1](./revise_your_aws_stack_to_create_a_multinode_swarm/04_join_script_01)** *(pp. 273-275)*
- **[Join Script - Part 2](./revise_your_aws_stack_to_create_a_multinode_swarm/04_join_script_02)** *(p. 276)*
- **[Join Script - Part 3](./revise_your_aws_stack_to_create_a_multinode_swarm/04_join_script_03)**
- **[Initial Deployment Automation](./revise_your_aws_stack_to_create_a_multinode_swarm/05_initial_deployment_automation)** *(pp. 277-284)*

---

## **09-Distributed Erlang**
Explore the power of distributed systems.

- **[Connect Multiple Releases](./distributed_erlang/01_connect_multiple_releases)** *(pp. 285-309)*

---

## **10-Autoscaling and Optimizing Your Deployment Strategy**
This chapter shows how to create robust, scalable deployments with AWS.

- **[Autoscaling Groups](./autoscaling_and_optimizing_your_deployment_strategy/01_autoscaling_group_and_launch_template)** *(pp. 310-317)*
- **[One Script to Rule Them All - Part 1](./autoscaling_and_optimizing_your_deployment_strategy/02_one_script_to_rule_them_all_01)** *(pp. 318-321)*
- **[One Script to Rule Them All - Part 2](./autoscaling_and_optimizing_your_deployment_strategy/02_one_script_to_rule_them_all_02)** *(pp. 322-324)*
- **[Implement Autoscaling](./autoscaling_and_optimizing_your_deployment_strategy/03_implement_autoscaling)** *(pp. 325-333)*
- **[Trigger Autoscaling](./autoscaling_and_optimizing_your_deployment_strategy/04_trigger_auto_scaling)** *(pp. 334-337)*
- **[Load Balancers](./autoscaling_and_optimizing_your_deployment_strategy/05_load_balancer)** *(pp. 338-342)*
- **[Automatic Rollbacks](./autoscaling_and_optimizing_your_deployment_strategy/06_automatic_rollbacks)** *(pp. 343-346)*
- **[Housekeeping Tasks](./autoscaling_and_optimizing_your_deployment_strategy/07_housekeeping_tasks)** *(pp. 347-351)*

---

## **11-Instrument Your Application with Logs and Metrics**
Learn to monitor your Elixir applications effectively.

- **[Add Logs](./instrument_your_application_with_logs_and_metrics/01_logs)** *(pp. 352-360)*
- **[Metrics and Promex](./instrument_your_application_with_logs_and_metrics/02_metrics_and_promex)** *(pp. 371-377)*
- **[Metrics and Grafana Dashboards](./instrument_your_application_with_logs_and_metrics/03_metrics_and_grafana_dashboards)** *(pp. 378-385)*
- **[Extra Mile](./instrument_your_application_with_logs_and_metrics/04_extra_mile)**

---

## **12-Create a Custom PromEx Metric and Grafana Alert**
Go beyond defaults to customize metrics and alerts.

- **[Custom PromEx Plugin](./create_a_custom_promex_metric_and_grafana_alert/01_cpu_promex_plugin)** *(pp. 386-398)*
- **[Custom Dashboard](./create_a_custom_promex_metric_and_grafana_alert/02_custom_dashboard)** *(pp. 399-404)*
- **[Custom Alerts](./create_a_custom_promex_metric_and_grafana_alert/03_custom_alert)** *(pp. 405-410)*
- **[Final Version](./create_a_custom_promex_metric_and_grafana_alert/04_final_version)** *(pp. 411-413)*
- **[Extra Mile](./create_a_custom_promex_metric_and_grafana_alert/05_extra_mile)**

---

 <p align="center">Made with ❤️ by Ellie & Pep.</p>
