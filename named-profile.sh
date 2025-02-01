#!/bin/bash

set -eu

# Check if required environment variables are set
if [[ -z "${aws_access_key_id:-}" ]] || 
   [[ -z "${aws_secret_access_key:-}" ]] || 
   [[ -z "${region:-}" ]] || 
   [[ -z "${profile_name:-}" ]]; then
    echo "Error: Required environment variables not set"
    echo "Please set: aws_access_key_id, aws_secret_access_key, region, and profile_name"
    exit 1
fi


# Configure AWS CLI with the provided credentials
aws configure set aws_access_key_id "${aws_access_key_id}" "${profile_name}"
aws configure set aws_secret_access_key "${aws_secret_access_key}" "${profile_name}"
aws configure set region "${region}" "${profile_name}"

echo "AWS credentials configured successfully for profile: ${profile_name}"
