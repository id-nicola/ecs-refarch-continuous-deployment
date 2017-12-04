#!/bin/bash
# CloudFormation Parameters
EP_ENV="${1:-test}"

# Stack name
STACK_NAME="ECS-ContinuousDeployment-${EP_ENV}"

# Get parameter stores
GITHUB_USER=$(aws ssm get-parameters --names "/ecsContinuousDeployment/github/user" --query Parameters[].Value --output text)
GITHUB_REPO=$(aws ssm get-parameters --names "/ecsContinuousDeployment/github/repo" --query Parameters[].Value --output text)
GITHUB_BRANCH=$(git rev-parse --abbrev-ref HEAD)
GITHUB_TOKEN=$(aws ssm get-parameters --names "/ecsContinuousDeployment/github/token" --query Parameters[].Value --output text)

aws cloudformation create-stack \
  --disable-rollback \
  --stack-name ${STACK_NAME} \
  --template-body "file://$(pwd)/ecs-refarch-continuous-deployment.yaml" --parameters \
  ParameterKey=GitHubUser,ParameterValue="${GITHUB_USER}" \
  ParameterKey=GitHubRepo,ParameterValue="${GITHUB_REPO}" \
  ParameterKey=GitHubBranch,ParameterValue="${GITHUB_BRANCH}" \
  ParameterKey=GitHubToken,ParameterValue="${GITHUB_TOKEN}" \
  --capabilities CAPABILITY_IAM
