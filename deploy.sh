#!/bin/zsh

STACK_NAME=$1
S3_BUCKET=$2

TEMPLATE_URL=template.yaml

S3_PREFIX=test

 aws cloudformation package \
   --region us-east-1 \
   --s3-bucket $S3_BUCKET \
   --s3-prefix $S3_PREFIX \
   --template-file $TEMPLATE_URL \
   --output-template-file packaged-template.yaml \
   || exit 1

aws cloudformation deploy \
  --stack-name $STACK_NAME \
  --region us-east-1 \
  --s3-bucket $S3_BUCKET \
  --s3-prefix $S3_PREFIX \
  --template-file packaged-template.yaml \
  --capabilities CAPABILITY_IAM \
  || exit 1

aws cloudformation describe-stacks \
  --stack-name $STACK_NAME \
  --region us-east-1 \
  --output text \
  --query 'Stacks[*].{StackName:StackName,CreationTime:CreationTime,Status:Status,Outputs:Outputs}' \
  || exit 1


