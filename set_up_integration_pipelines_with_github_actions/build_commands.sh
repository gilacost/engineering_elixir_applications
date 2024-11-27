#!/usr/bin/env bash

set -ex

# Loop through each folder in the current directory
for repo_dir in */; do
    # Strip trailing slash
    repo_dir=${repo_dir%/}
    
    echo "Entering directory: $repo_dir"
    
    # Run mix deps.get in each folder to ensure dependencies are fetched
    (cd "$repo_dir" && mix deps.get)
    
    # Check if the directory name contains certain keywords and act accordingly
    case "$repo_dir" in
        *failing_mix_compile*)
            echo "Checking for failures in mix compile in $repo_dir..."
            if ! (cd "$repo_dir" && mix compile --warnings-as-errors); then
                echo "$repo_dir: mix compile failed as expected."
            else
                echo "$repo_dir: mix compile succeeded unexpectedly!"
                exit 1
            fi
            ;;
        
        *failing_mix_format*)
            echo "Checking for failures in mix format in $repo_dir..."
            if ! (cd "$repo_dir" && mix format --check-formatted); then
                echo "$repo_dir: mix format check failed as expected."
            else
                echo "$repo_dir: mix format check succeeded unexpectedly!"
                exit 1
            fi
            ;;
        
        *failing_dialyzer*)
            echo "Checking for Dialyzer failures in $repo_dir..."
            if ! (cd "$repo_dir" && mix dialyzer); then
                echo "$repo_dir: Dialyzer failed as expected."
            else
                echo "$repo_dir: Dialyzer succeeded unexpectedly!"
                exit 1
            fi
            ;;
        
        *failing_mix_test*)
            echo "Checking for failures in mix test in $repo_dir..."
            if ! (cd "$repo_dir" && mix test); then
                echo "$repo_dir: mix test failed as expected."
            else
                echo "$repo_dir: mix test succeeded unexpectedly!"
                exit 1
            fi
            ;;
        
        *successful_mix_compile*)
            echo "Checking for successful mix compile in $repo_dir..."
            if (cd "$repo_dir" && mix compile --warnings-as-errors); then
                echo "$repo_dir: mix compile succeeded."
            else
                echo "$repo_dir: mix compile failed unexpectedly!"
                exit 1
            fi
            ;;
        
        *successful_mix_format*)
            echo "Checking for successful mix format in $repo_dir..."
            if (cd "$repo_dir" && mix format --check-formatted); then
                echo "$repo_dir: mix format check succeeded."
            else
                echo "$repo_dir: mix format check failed unexpectedly!"
                exit 1
            fi
            ;;
        
        *successful_dialyzer*)
            echo "Checking for successful Dialyzer run in $repo_dir..."
            if (cd "$repo_dir" && mix dialyzer); then
                echo "$repo_dir: Dialyzer succeeded."
            else
                echo "$repo_dir: Dialyzer failed unexpectedly!"
                exit 1
            fi
            ;;
        
        *successful_mix_test*)
            echo "Checking for successful mix test in $repo_dir..."
            if (cd "$repo_dir" && mix test); then
                echo "$repo_dir: mix test succeeded."
            else
                echo "$repo_dir: mix test failed unexpectedly!"
                exit 1
            fi
            ;;
        
        *unused_dependencies*)
            echo "Checking for unused dependencies in $repo_dir..."
            if (cd "$repo_dir" && mix deps.unlock --check-unused); then
                echo "$repo_dir: No unused dependencies found."
            else
                echo "$repo_dir: Unused dependencies check failed."
                exit 1
            fi
            ;;
        
        *cache_docker_build*)
            echo "Testing Docker build caching in $repo_dir..."
            # This is only a workflow
            ;;
        
        *build_docker*)
            echo "Building Docker image in $repo_dir..."
            # This is only a workflow
            ;;
        
        *multi_arch*)
            echo "Testing multi-architecture build in $repo_dir..."
            # This is only a workflow
            ;;
        
        *triggers*)
            echo "Running trigger tests in $repo_dir..."
            # This is only a workflow
            ;;
        
        *)
            echo "Unknown operation in $repo_dir. Skipping..."
            ;;
    esac
done
