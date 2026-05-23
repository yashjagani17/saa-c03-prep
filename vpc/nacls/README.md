# Create VPC, EC2, SSM via CFN
../basics/./template.yaml
aws cloudformation create-stack --stack-name stack --template-body file://template.yaml --capabilities CAPABILITY_IAM

# Get VPC ID
```sh
echo "VPC_ID: $(aws ec2 describe-vpcs \
    --filters "Name=tag:Name,Values=VPC" \
    --query Vpcs[].VpcId \
    --output text)"
```
VPC_ID: vpc-0b55dfa001b4c63d9

# Get Subnet ID
```sh
echo "SUBNET_ID: $(aws ec2 describe-subnets \
    --filters "Name=vpc-id,Values=vpc-0b55dfa001b4c63d9" \
    --query Subnets[0].SubnetId \
    --output text)"
```
SUBNET_ID: subnet-042c6c5b2efd05b34

# Get Subnet NACL Association ID 
```sh
aws ec2 describe-network-acls \
    --filters "Name=association.subnet-id,Values=subnet-042c6c5b2efd05b34" \
    --query "NetworkAcls[*].Associations[?SubnetId=='subnet-042c6c5b2efd05b34'].NetworkAclAssociationId" \
    --output text
```
aclassoc-06853a02a4cc9e8fd

# Create NACL FIX THIS to match the subnet
```sh
echo "NACL_ID: $(aws ec2 create-network-acl \
    --vpc-id vpc-0b55dfa001b4c63d9 \
    --subnet
    --query NetworkAcl.NetworkAclId \
    --output text)"
```
NACL_ID: acl-00e53cd6834255ba5

# Add NACL rule to deny traffic from my IP address
```sh
aws ec2 create-network-acl-entry \
    --network-acl-id acl-00e53cd6834255ba5 \
    --ingress \
    --rule-number 90 \
    --protocol -1 \
    --cidr-block 82.13.165.108/32 \
    --rule-action deny
```

# Associate NACL with the Subnet
```sh
aws ec2 replace-network-acl-association \
    --association-id aclassoc-06853a02a4cc9e8fd \
    --network-acl-id acl-00e53cd6834255ba5
```
{
    "NewAssociationId": "aclassoc-09067760e3e848246"
}

# Cleanup
```sh
aws ec2 delete-network-acl --network-acl-id acl-00e53cd6834255ba5
aws cloudformation delete-stack --stack-name mystack
```