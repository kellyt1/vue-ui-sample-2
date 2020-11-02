#! /bin/bash

# 01-build-cloudfront.sh

source env.sh

URL=${WEB_SUBDOMIAN}.${HOSTED_ZONE}

echo "Url =    " ${URL}

aws cloudformation deploy --stack-name ${STACKNAME} --template-file ${TEMPLATEFILE} --capabilities CAPABILITY_NAMED_IAM --parameter-overrides AppUrl=${URL} BaseUrl=${HOSTED_ZONE} AcmCertArn=${CERT_ARN}
        
