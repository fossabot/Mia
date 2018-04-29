#!/bin/bash

base_dir=$(dirname "$0")
cd "$base_dir"

# Checking spec lint
echo -e "\033[1;35m *** Installing Pods *** \033[0m"
pod install --project-directory=Example
echo -e "\033[1;32m *** Installing Pods Completed *** \033[0m"
