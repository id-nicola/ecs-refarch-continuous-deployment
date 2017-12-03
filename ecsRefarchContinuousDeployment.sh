#!/bin/bash
# CloudFormation Parameters
EP_ENV="${1:-test}"

# Stack name
STACK_NAME="ECS-ContinuousDeployment-${EP_ENV}"

aws cloudformation create-stack \
  --disable-rollback \
  --stack-name ${STACK_NAME} \
  --template-body "file://$(pwd)/ecs-refarch-continuous-deployment.yaml" --parameters \
  ParameterKey=GitHubUser,ParameterValue="" \
  ParameterKey=GitHubRepo,ParameterValue="" \
  ParameterKey=GitHubBranch,ParameterValue="master" \
  ParameterKey=GitHubToken,ParameterValue="" \
  --capabilities CAPABILITY_IAM
