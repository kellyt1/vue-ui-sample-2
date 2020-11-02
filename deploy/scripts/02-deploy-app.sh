#! /bin/bash
# 01-deploy-app.sh

source env.sh

S3BUCKET=$(aws cloudformation describe-stacks --stack-name ${STACKNAME} --query "Stacks[0].Outputs[?OutputKey=='AppBucket'].OutputValue" --output text)
DISTID=$(aws cloudformation describe-stacks --stack-name ${STACKNAME} --query "Stacks[0].Outputs[?OutputKey=='DistributionId'].OutputValue" --output text)

echo "S3 Bucket        " ${S3BUCKET}
echo "Distribution ID  " ${DISTID}

#aws s3 sync ../../dist/ s3://${S3BUCKET}
aws s3 sync --cache-control 'max-age=604800' --exclude index.html ../../dist/ s3://${S3BUCKET}
aws s3 sync --cache-control 'no-cache' ../../dist/  s3://${S3BUCKET}

#aws cloudfront create-invalidation --distribution-id ${DISTID} --paths /
