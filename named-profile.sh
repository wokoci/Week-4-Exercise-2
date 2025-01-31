#!/bin/bash

set -eu

aws configure set aws_access_key_id $1 --profile $2
aws configure set aws_secret_access_key $3 --profile $2
aws configure set region $4 --profile $2