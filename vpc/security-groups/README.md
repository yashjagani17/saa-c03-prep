# Create VPC, EC2, SSM via CFN
../basics/./template.yaml
aws cloudformation create-stack --stack-name stack --template-body file://template.yaml --capabilities CAPABILITY_IAM
InstanceId: i-06b6dd941855d0c91
InstanceIp: http://18.133.185.44
SecurityGroupId: sg-03079ec7a5e93560d
SubnetId: subnet-0834433a87c1ef1bc
VpcId: vpc-0ba1cafb4ce7ef624

# Get Security Group Rule ID
```sh
aws ec2 describe-security-group-rules --filters Name="group-id",Values="sg-03079ec7a5e93560d"
```
{
    "SecurityGroupRules": [
        {
            "SecurityGroupRuleId": "sgr-0fbb44bdb890be150",
            "GroupId": "sg-03079ec7a5e93560d",
            "GroupOwnerId": "425560113058",
            "IsEgress": true,
            "IpProtocol": "-1",
            "FromPort": -1,
            "ToPort": -1,
            "CidrIpv4": "0.0.0.0/0",
            "Tags": [],
            "SecurityGroupRuleArn": "arn:aws:ec2:eu-west-2:425560113058:security-group-rule/sgr-0fbb44bdb890be150"
        },
        {
            "SecurityGroupRuleId": "sgr-09f2e54dd6894d762",
            "GroupId": "sg-03079ec7a5e93560d",
            "GroupOwnerId": "425560113058",
            "IsEgress": false,
            "IpProtocol": "tcp",
            "FromPort": 80,
            "ToPort": 80,
            "CidrIpv4": "0.0.0.0/0",
            "Tags": [],
            "SecurityGroupRuleArn": "arn:aws:ec2:eu-west-2:425560113058:security-group-rule/sgr-09f2e54dd6894d762"
        }
    ]
}

# Modify SG rule
```sh
aws ec2 modify-security-group-rules \
    --group-id sg-03079ec7a5e93560d \
    --security-group-rules SecurityGroupRuleId=sgr-09f2e54dd6894d762,SecurityGroupRule='{Description=allow-ssh,IpProtocol=22,CidrIpv4=0.0.0.0/0}'
```
replaced HTTP rule with SSH rule so webpage won't load

# Change SG rule again back to allow HTTP
```sh
aws ec2 modify-security-group-rules \
    --group-id sg-03079ec7a5e93560d \
    --security-group-rules SecurityGroupRuleId=sgr-09f2e54dd6894d762,SecurityGroupRule='{Description=allow-http,IpProtocol=tcp,FromPort=80,ToPort=80,CidrIpv4=0.0.0.0/0}'
```
replaced SSH rule back to HTTP rule so webpage is accessible