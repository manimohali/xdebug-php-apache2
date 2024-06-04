#!/bin/bash




# Run the wp core version command and capture the output
wp_core_version=$(wp core version)

# Print the captured output
echo "$wp_core_version"
