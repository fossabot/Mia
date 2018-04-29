#!/bin/bash

base_dir=$(dirname "$0")
cd "$base_dir"

# Checking spec lint
echo -e "\033[1;35m *** Linting Swift *** \033[0m"
swiftlint
echo -e "\033[1;32m *** Linting Swift Completed *** \033[0m"

# Checking spec lint
echo -e "\033[1;35m *** Linting Podspec File *** \033[0m"
pod spec lint
echo -e "\033[1;32m *** Linting Podspec File Completed *** \033[0m"

# Checking lib lint
echo -e "\033[1;35m *** Linting Library *** \033[0m"
pod lib lint
echo -e "\033[1;32m *** Linting Library Completed *** \033[0m"
