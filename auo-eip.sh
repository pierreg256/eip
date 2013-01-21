#!/bin/bash

ROLE=$(curl -s http://169.254.169.254/latest/meta-data/iam/security-credentials/)
CREDENTIALS=$(curl -s http://169.254.169.254/latest/meta-data/iam/security-credentials/${ROLE})
ACCESS_KEY=$(curl -s http://169.254.169.254/latest/meta-data/iam/security-credentials/${ROLE} | grep AccessKeyId | sed -e "s/.*\"AccessKeyId\" : \"//g" | sed -e "s/\",$//g")
SECRET_KEY=$(curl -s http://169.254.169.254/latest/meta-data/iam/security-credentials/${ROLE} | grep SecretAccessKey | sed -e "s/.*\"SecretAccessKey\" : \"//g" | sed -e "s/\",$//g")

INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
USERDATA=$(curl -s http://169.254.169.254/latest/user-data)
ELASTIC_IP=$(echo $USERDATA | awk 'BEGIN{RS="|";FS="="} /elastic-ip/ {print $2}')
ELASTIC_HOSTNAME=$(echo $USERDATA | awk 'BEGIN{RS="|";FS="="} /hostname/ {print $2}')
REGION=$(echo $USERDATA | awk 'BEGIN{RS="|";FS="="} /region/ {print $2}')

echo "Instance ID  : $INSTANCE_ID" > /tmp/pierre.log
echo "Elatsic IP   : $ELASTIC_IP" >> /tmp/pierre.log
echo "Access Key   : $ACCESS_KEY" >> /tmp/pierre.log
echo "Secret Key   : $SECRET_KEY" >> /tmp/pierre.log

/opt/aws/bin/ec2-associate-address --region $REGION --instance $INSTANCE_ID $ELASTIC_IP >> /tmp/pierre.log 2>&1

RES=$?
echo "the result is : $RES" >> /tmp/pierre.log