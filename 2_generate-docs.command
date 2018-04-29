#!/bin/bash

base_dir=$(dirname "$0")
cd "$base_dir"

echo -e "\033[1;35m *** Updating Documentations *** \033[0m"
jazzy
echo -e "\033[1;32m *** Updating Documentations Completed *** \033[0m"
