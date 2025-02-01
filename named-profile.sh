#!/bin/bash

set -eu

export AWS_ACCESS_KEY_ID="your_access_key"
export AWS_SECRET_ACCESS_KEY="your_secret_key"
export AWS_DEFAULT_REGION="eu-west-1"  # optional, defaults to eu-west-1

# Check if profile name is provided as an argument
if [ $# -eq 0 ]; then
    echo "Error: Profile name not provided"
    echo "Usage: $0 <profile_name>"
    exit 1
fi

profile_name="$1"

# Check if required environment variables are set
if [ -z "${AWS_ACCESS_KEY_ID:-}" ] || [ -z "${AWS_SECRET_ACCESS_KEY:-}" ]; then
    echo "Error: AWS credentials not set in environment variables"
    echo "Please set AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY"
    exit 1
fi

# Set default region if not provided in environment
REGION="${AWS_DEFAULT_REGION:-eu-west-1}"

echo "Configuring AWS CLI profile: $profile_name"

# Configure AWS CLI with the provided credentials
aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID" --profile "$profile_name"
aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY" --profile "$profile_name"
aws configure set region "$REGION" --profile "$profile_name"

# Verify the configuration
if aws sts get-caller-identity --profile "$profile_name" &> /dev/null; then
    echo "AWS credentials configured successfully for profile: $profile_name"
    echo "Region set to: $REGION"
else
    echo "Error: Failed to verify AWS credentials"
    exit 1
fi
