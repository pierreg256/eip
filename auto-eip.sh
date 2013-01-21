#!/bin/bash

LOG=/tmp/auto-eip.log

ROLE=$(curl -s http://169.254.169.254/latest/meta-data/iam/security-credentials/)
CREDENTIALS=$(curl -s http://169.254.169.254/latest/meta-data/iam/security-credentials/${ROLE})
ACCESS_KEY=$(curl -s http://169.254.169.254/latest/meta-data/iam/security-credentials/${ROLE} | grep AccessKeyId | sed -e "s/.*\"AccessKeyId\" : \"//g" | sed -e "s/\",$//g")
SECRET_KEY=$(curl -s http://169.254.169.254/latest/meta-data/iam/security-credentials/${ROLE} | grep SecretAccessKey | sed -e "s/.*\"SecretAccessKey\" : \"//g" | sed -e "s/\",$//g")

INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
USERDATA=$(curl -s http://169.254.169.254/latest/user-data)
ELASTIC_IP=$(echo $USERDATA | awk 'BEGIN{RS="|";FS="="} /elastic-ip/ {print $2}')
ELASTIC_HOSTNAME=$(echo $USERDATA | awk 'BEGIN{RS="|";FS="="} /hostname/ {print $2}')
REGION=$(echo $USERDATA | awk 'BEGIN{RS="|";FS="="} /region/ {print $2}')

echo "Instance ID  : $INSTANCE_ID" > $LOG
echo "Elatsic IP   : $ELASTIC_IP" >> $LOG
echo "Access Key   : $ACCESS_KEY" >> $LOG
echo "Secret Key   : $SECRET_KEY" >> $LOG

/opt/aws/bin/ec2-associate-address --region $REGION --instance $INSTANCE_ID $ELASTIC_IP >> $LOG 2>&1

RES=$?
echo "the result is : $RES" >> $LOG