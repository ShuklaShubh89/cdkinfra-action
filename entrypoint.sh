#!/bin/bash

set -o errexit

# Validate AWS Credentials

if [ "${AWS_ACCESS_KEY_ID}" == "" ]; then
  echo "Input AWS_ACCESS_KEY_ID cannot be empty"
  exit 1
fi

if [ "${AWS_SECRET_ACCESS_KEY}" == "" ]; then
  echo "Input AWS_SECRET_ACCESS_KEY cannot be empty"
  exit 1
fi

if [ "${AWS_DEFAULT_REGION}" == "" ]; then
  echo "Input AWS_DEFAULT_REGION cannot be empty"
  exit 1
fi

if [ "${INPUT_CDK_ACTION}" == "" ]; then
  echo "Input INPUT_CDK_ACTION cannot be empty"
  exit 1
fi

# Configure AWS cli with a default profile
aws configure set aws_access_key_id "${AWS_ACCESS_KEY_ID}"
aws configure set aws_secret_access_key "${AWS_SECRET_ACCESS_KEY}"
aws configure set default.region "${AWS_DEFAULT_REGION}"

echo "cdk version:"
cdk --version

npm run build

npm run test

# Run cdk for a specific stack
if [[ "${INPUT_CDK_STACK_DIRECTORY}" != '' && "${INPUT_CDK_STACK}" != '' ]]; then
  cd "${GITHUB_WORKSPACE}"/"${INPUT_CDK_STACK_DIRECTORY}"
  cdk ${INPUT_CDK_ACTION} ${INPUT_CDK_STACK}
  exit 0;
fi