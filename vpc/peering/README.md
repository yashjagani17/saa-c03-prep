via aws management console

# Create VPC A with CIDR 10.0.0.0/16 with 1 public subnet

# Create VPC B with CIDR 11.0.0.0/16 with 1 public subnet

# Create peering connection
```sh
aws ec2 create-vpc-peering-connection --vpc-id vpc-056431a3bfc944db6 --peer-vpc-id vpc-05163f8ad8f72226b --peer-region eu-west-2
```
{
    "VpcPeeringConnection": {
        "AccepterVpcInfo": {
            "OwnerId": "425560113058",
            "VpcId": "vpc-05163f8ad8f72226b",
            "Region": "eu-west-2"
        },
        "ExpirationTime": "2026-05-30T21:59:26+00:00",
        "RequesterVpcInfo": {
            "CidrBlock": "10.0.0.0/16",
            "CidrBlockSet": [
                {
                    "CidrBlock": "10.0.0.0/16"
                }
            ],
            "OwnerId": "425560113058",
            "PeeringOptions": {
                "AllowDnsResolutionFromRemoteVpc": false,
                "AllowEgressFromLocalClassicLinkToRemoteVpc": false,
                "AllowEgressFromLocalVpcToRemoteClassicLink": false
            },
            "VpcId": "vpc-056431a3bfc944db6",
            "Region": "eu-west-2"
        },
        "Status": {
            "Code": "initiating-request",
            "Message": "Initiating Request to 425560113058"
        },
        "Tags": [],
        "VpcPeeringConnectionId": "pcx-0a64881a56d65397f"
    }
}

# Accept peering connection
```sh
aws ec2 accept-vpc-peering-connection --vpc-peering-connection-id pcx-0a64881a56d65397f
```
{
    "VpcPeeringConnection": {
        "AccepterVpcInfo": {
            "CidrBlock": "11.0.0.0/16",
            "CidrBlockSet": [
                {
                    "CidrBlock": "11.0.0.0/16"
                }
            ],
            "OwnerId": "425560113058",
            "PeeringOptions": {
                "AllowDnsResolutionFromRemoteVpc": false,
                "AllowEgressFromLocalClassicLinkToRemoteVpc": false,
                "AllowEgressFromLocalVpcToRemoteClassicLink": false
            },
            "VpcId": "vpc-05163f8ad8f72226b",
            "Region": "eu-west-2"
        },
        "RequesterVpcInfo": {
            "CidrBlock": "10.0.0.0/16",
            "CidrBlockSet": [
                {
                    "CidrBlock": "10.0.0.0/16"
                }
            ],
            "OwnerId": "425560113058",
            "PeeringOptions": {
                "AllowDnsResolutionFromRemoteVpc": false,
                "AllowEgressFromLocalClassicLinkToRemoteVpc": false,
                "AllowEgressFromLocalVpcToRemoteClassicLink": false
            },
            "VpcId": "vpc-056431a3bfc944db6",
            "Region": "eu-west-2"
        },
        "Status": {
            "Code": "provisioning",
            "Message": "Provisioning"
        },
        "Tags": [],
        "VpcPeeringConnectionId": "pcx-0a64881a56d65397f"
    }
}

# Add route to route table in both VPC A and VPC B
```sh
aws ec2 create-route --route-table-id rtb-09f2b73e57c2459bf --destination-cidr-block 11.0.0.0/16 --vpc-peering-connection-id pcx-0a64881a56d65397f 
```
{
    "Return": true
}
```sh
aws ec2 create-route --route-table-id rtb-0ada97574ad694db0 --destination-cidr-block 10.0.0.0/16 --vpc-peering-connection-id pcx-0a64881a56d65397f 
```
{
    "Return": true
}

# Launch an EC2 instance via CFN in VPC A with SSM
```sh
aws cloudformation create-stack --stack-name stack-a --template-body file://template-a.yaml --capabilities CAPABILITY_IAM
```
{
    "StackId": "arn:aws:cloudformation:eu-west-2:425560113058:stack/stack-a/8ce980e0-56f7-11f1-847a-023a1f40a839",
    "OperationId": "90a94800-56f7-11f1-937d-0a9c39a8eaa1"
}

# Launch an EC2 instance in VPC B without SSM hosting a web server
```sh
aws cloudformation create-stack --stack-name stack-b --template-body file://template-b.yaml
```
{
    "StackId": "arn:aws:cloudformation:eu-west-2:425560113058:stack/stack-b/9823a620-56f7-11f1-8402-02ec5d8003d9",
    "OperationId": "9824b790-56f7-11f1-8402-02ec5d8003d9"
}

# Confirm VPC peering connectivity via wget to private IP address of webserver
```sh
wget -qO - http://11.0.12.217
<html><body><h1>hello from apache linux 2</h1></body></html>
```

# Cleanup
```sh
aws cloudformation delete-stack --stack-name stack-a
aws cloudformation delete-stack --stack-name stack-b
aws ec2 delete-vpc-peering-connection --vpc-peering-connection-id pcx-0a64881a56d65397f

```
manually delete vpcs via management console