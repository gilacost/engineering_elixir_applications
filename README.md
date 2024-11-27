# Engineering Elixir Applications: Source Code

This repository contains the source code for the chapters of [*Engineering Elixir Applications*](https://pragprog.com/titles/beamops/engineering-elixir-applications/). These materials are shared with permission from [PragProg](https://pragprog.com). 

<img src="images/book.jpg" width=25% />

The examples included are:

---

## **Introduction**
This code sets up the foundation for the journey, providing scripts to get started with the tools and concepts covered throughout the book.

- **[Introduction to the Journey](./introduction_to_the_journey/scripts)**: Scripts for initial setup.

---

## **Use Terraform to Create GitHub Issues and Milestones**
Automate GitHub repository setup using Terraform.

- **[Initial Setup](./use_terraform_to_create_github_issues_and_milestones/01_initial_setup)**
- **[Local Values](./use_terraform_to_create_github_issues_and_milestones/02_local_values)**
- **[Initial Milestones Setup](./use_terraform_to_create_github_issues_and_milestones/03_initial_milestones_setup)**
- **[Milestones with Variables](./use_terraform_to_create_github_issues_and_milestones/04_milestones_with_variables)**
- **[Labels](./use_terraform_to_create_github_issues_and_milestones/05_labels)**
- **[Resource Dependencies](./use_terraform_to_create_github_issues_and_milestones/06_resource_dependencies)**
- **[Issues](./use_terraform_to_create_github_issues_and_milestones/07_issues)**
- **[Extra Mile](./use_terraform_to_create_github_issues_and_milestones/08_extra_mile)**
- **[Final Version](./use_terraform_to_create_github_issues_and_milestones/final_version)**

---

## **Build and Dockerize a Phoenix LiveView Application**
This chapter guides you through creating a Dockerized Phoenix LiveView application.

- **[FROM](./build_and_dockerize_a_phoenix_liveview_application/01_from)**
- **[ARGS](./build_and_dockerize_a_phoenix_liveview_application/02_args)**
- **[Compile Dependencies](./build_and_dockerize_a_phoenix_liveview_application/03_compile_deps)**
- **[Release Configuration](./build_and_dockerize_a_phoenix_liveview_application/04_release_config)**
- **[Mix Release](./build_and_dockerize_a_phoenix_liveview_application/05_mix_release)**
- **[Multi-Stage Builds](./build_and_dockerize_a_phoenix_liveview_application/06_multi_stage)**

---

## **Set Up Integration Pipelines with GitHub Actions**
Learn to create robust CI/CD pipelines using GitHub Actions.

- **[Failing Mix Compile](./set_up_integration_pipelines_with_github_actions/01_failing_mix_compile)**
- **[Successful Mix Compile](./set_up_integration_pipelines_with_github_actions/01_successful_mix_compile)**
- **[Caching Dependencies](./set_up_integration_pipelines_with_github_actions/02_cache_deps_build)**
- **[Conditional Steps](./set_up_integration_pipelines_with_github_actions/03_conditional_steps)**
- **[Failing Mix Test](./set_up_integration_pipelines_with_github_actions/04_failing_mix_test)**
- **[Successful Mix Test](./set_up_integration_pipelines_with_github_actions/04_successful_mix_test)**
- **[Failing Mix Format](./set_up_integration_pipelines_with_github_actions/05_failing_mix_format)**
- **[Successful Mix Format](./set_up_integration_pipelines_with_github_actions/05_successful_mix_format)**
- **[Failing Dialyzer](./set_up_integration_pipelines_with_github_actions/06_failing_dialyzer)**
- **[Successful Dialyzer](./set_up_integration_pipelines_with_github_actions/06_successful_dialyzer)**
- **[Unused Dependencies](./set_up_integration_pipelines_with_github_actions/07_unused_dependencies)**
- **[Build Docker](./set_up_integration_pipelines_with_github_actions/08_build_docker)**
- **[Cache Docker Build](./set_up_integration_pipelines_with_github_actions/09_cache_docker_build)**
- **[Multi-Arch Builds](./set_up_integration_pipelines_with_github_actions/10_multi_arch)**
- **[Triggers](./set_up_integration_pipelines_with_github_actions/11_triggers)**
- **[Extra Mile](./set_up_integration_pipelines_with_github_actions/12_extra_mile)**

---

## **The Development Environment and Docker Compose**
Set up a development environment with Docker Compose.

- **[Phoenix with Ecto](./the_dev_environment_and_docker_compose/01_phx_with_ecto)**
- **[Postgres Simple Setup](./the_dev_environment_and_docker_compose/02_postgres_simple)**
- **[Postgres Ports Published (Hardcoded)](./the_dev_environment_and_docker_compose/03_postgres_ports_published_hardcoded)**
- **[Postgres Ports Published](./the_dev_environment_and_docker_compose/04_postgres_ports_published)**
- **[Postgres Pinned Version](./the_dev_environment_and_docker_compose/05_postgres_pinned_version)**
- **[Postgres Explicit Volume](./the_dev_environment_and_docker_compose/06_postgres_explicit_volume)**
- **[Adding Phoenix to Compose](./the_dev_environment_and_docker_compose/07_adding_your_phoenix_app)**
- **[Update Your CI Pipeline](./the_dev_environment_and_docker_compose/08_update_your_ci_pipeline)**
- **[Extra Mile](./the_dev_environment_and_docker_compose/09_extra_mile)**

---

## **Autoscaling and Optimizing Your Deployment Strategy**
This chapter shows how to create robust, scalable deployments with AWS.

- **[Autoscaling Groups](./autoscaling_and_optimizing_your_deployment_strategy/01_autoscaling_group_and_launch_template)**
- **[One Script to Rule Them All - Part 1](./autoscaling_and_optimizing_your_deployment_strategy/02_one_script_to_rule_them_all_01)**
- **[One Script to Rule Them All - Part 2](./autoscaling_and_optimizing_your_deployment_strategy/02_one_script_to_rule_them_all_02)**
- **[Implement Autoscaling](./autoscaling_and_optimizing_your_deployment_strategy/03_implement_autoscaling)**
- **[Trigger Autoscaling](./autoscaling_and_optimizing_your_deployment_strategy/04_trigger_auto_scaling)**
- **[Load Balancers](./autoscaling_and_optimizing_your_deployment_strategy/05_load_balancer)**
- **[Automatic Rollbacks](./autoscaling_and_optimizing_your_deployment_strategy/06_automatic_rollbacks)**
- **[Housekeeping Tasks](./autoscaling_and_optimizing_your_deployment_strategy/07_housekeeping_tasks)**

---

## **Revise Your AWS Stack to Create a Multi-Node Swarm**
Build a highly available Docker Swarm using AWS.

- **[Multiple EC2 Instances](./revise_your_aws_stack_to_create_a_multinode_swarm/01_multiple_ec2_instances)**
- **[Multi-Node Swarm](./revise_your_aws_stack_to_create_a_multinode_swarm/02_multinode_swarm)**
- **[Initialize Script](./revise_your_aws_stack_to_create_a_multinode_swarm/03_initialize_script)**
- **[Join Script - Part 1](./revise_your_aws_stack_to_create_a_multinode_swarm/04_join_script_01)**
- **[Join Script - Part 2](./revise_your_aws_stack_to_create_a_multinode_swarm/04_join_script_02)**
- **[Join Script - Part 3](./revise_your_aws_stack_to_create_a_multinode_swarm/04_join_script_03)**
- **[Initial Deployment Automation](./revise_your_aws_stack_to_create_a_multinode_swarm/05_initial_deployment_automation)**

---

## **Distributed Erlang**
Explore the power of distributed systems.

- **[Connect Multiple Releases](./distributed_erlang/01_connect_multiple_releases)**

---

## **Instrument Your Application with Logs and Metrics**
Learn to monitor your Elixir applications effectively.

- **[Add Logs](./instrument_your_application_with_logs_and_metrics/01_logs)**
- **[Metrics and Promex](./instrument_your_application_with_logs_and_metrics/02_metrics_and_promex)**
- **[Metrics and Grafana Dashboards](./instrument_your_application_with_logs_and_metrics/03_metrics_and_grafana_dashboards)**
- **[Extra Mile](./instrument_your_application_with_logs_and_metrics/04_extra_mile)**

---

## **Create a Custom Promex Metric and Grafana Alert**
Go beyond defaults to customize metrics and alerts.

- **[Custom Promex Plugin](./create_a_custom_promex_metric_and_grafana_alert/01_cpu_promex_plugin)**
- **[Custom Dashboard

](./create_a_custom_promex_metric_and_grafana_alert/02_custom_dashboard)**
- **[Custom Alerts](./create_a_custom_promex_metric_and_grafana_alert/03_custom_alert)**
- **[Final Version](./create_a_custom_promex_metric_and_grafana_alert/04_final_version)**
- **[Extra Mile](./create_a_custom_promex_metric_and_grafana_alert/05_extra_mile)**
