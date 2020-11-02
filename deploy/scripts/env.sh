#! /bin/bash

# env.sh

# set application specific items
export WEB_SUBDOMIAN=hepdataportalui
export STACKNAME=$WEB_SUBDOMIAN-ui-s3cloudfront-stack
CERT_ARN_NONPROD=arn:aws:acm:us-east-1:938619397650:certificate/4fe467c4-09e0-4115-b91c-819505c63b26
CERT_ARN_PROD=arn:aws:acm:us-east-1:100582527228:certificate/TBD

# set template specific items
export TEMPLATEFILE=../cloudformation/s3-cloudfront.yml

# get account id and region
export ACCOUNT=$(aws sts get-caller-identity --output text --query 'Account')
export REGION=$(aws configure get region)

# set environmented based on account id
if [ "$ACCOUNT" = "938619397650" ]; then
	echo "Setting Non-Production Environment Variables"
	export ENVIRONMENT=nonprod
	export HOSTED_ZONE=nonprod.health.state.mn.us
	export CERT_ARN=$CERT_ARN_NONPROD
elif [ "$ACCOUNT" = "100582527228" ]; then
	echo "Setting Production Environment Variables"
	export ENVIRONMENT=prod
	export HOSTED_ZONE=web.health.state.mn.us
	export CERT_ARN=$CERT_ARN_PROD
else
	export ENVIRONMENT=unknown
	echo "The environment is not known."
	echo "Do you need to login? (awsauth.py)"
	exit 1;
fi

# check for cert settings
if [ "$CERT_ARN" = "unknown" ]; then
	echo "Please set the certificate ARN for this environment (${ENVIRONMENT})."
	exit 2;
fi

# check region
#if [ "$REGION" != "us-east-2" ]; then
#	echo "The region is not es-east-2."
#	echo "Are you sure you want to create stuff here?"
#	exit 3;
#fi

echo "Environment                 " ${ENVIRONMENT}
echo "Account                     " ${ACCOUNT}
echo "Region                      " ${REGION}
echo "Stack Name                  " ${STACKNAME}
echo "WEB Subdomain               " ${WEB_SUBDOMIAN}
echo "Hosted Zone                 " ${HOSTED_ZONE}
echo "Cert ARN                    " ${CERT_ARN}
echo "Original Template File      " ${TEMPLATEFILE}

