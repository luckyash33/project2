#!/bin/bash
# ONE-TIME SETUP SCRIPT
# Run this manually once before the GitHub Actions CI/CD pipeline is used.
# It creates the ECR repositories and pushes an initial :latest image for each service.
# After this, all builds and pushes are handled automatically by .github/workflows/ci-cd.yml
set -e

# Set variables
export AWS_REGION=ap-south-1
export ACCOUNT_ID=655700896650
export REGISTRY=${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

echo "=== Creating ECR repositories ==="
for SERVICE in frontend user-service task-service notification-service analytics-service; do
  aws ecr describe-repositories --region $AWS_REGION --repository-names task-management/$SERVICE 2>/dev/null || \
  aws ecr create-repository --region $AWS_REGION --repository-name task-management/$SERVICE
done

echo ""
echo "=== Logging into ECR ==="
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $REGISTRY

echo ""
echo "=== Building and pushing images ==="
for SERVICE in frontend user-service task-service notification-service analytics-service; do
  echo "Building $SERVICE..."
  docker buildx build --platform linux/amd64 --load -t task-management/$SERVICE ./$SERVICE
  docker tag task-management/$SERVICE:latest $REGISTRY/task-management/$SERVICE:latest
  docker push $REGISTRY/task-management/$SERVICE:latest
  echo "✓ $SERVICE pushed successfully"
  echo ""
done

echo "=== All images pushed successfully ==="