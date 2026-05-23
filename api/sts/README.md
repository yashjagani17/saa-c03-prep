# Create a user with no permissions
```sh
aws iam create-user --user-name sts-testuser
```
{
    "User": {
        "Path": "/",
        "UserName": "sts-testuser",
        "UserId": "KEY_HERE"
        "Arn": "arn:aws:iam::425560113058:user/sts-testuser",
        "CreateDate": "2026-05-15T13:45:44+00:00"
    }
}

# Create access key for the user
```sh
aws iam create-access-key --user-name sts-testuser
```
{
    "AccessKey": {
        "UserName": "sts-testuser",
        "AccessKeyId": "KEY_HERE"
        "Status": "Active",
        "SecretAccessKey": "KEY_HERE",
        "CreateDate": "2026-05-15T13:46:40+00:00"
    }
}

# Configure ~/.aws/credentials 
```sh
aws configure
```
AWS Access Key ID [None]: KEY_HERE
AWS Secret Access Key [None]: KEY_HERE
Default region name [eu-west-2]: 
Default output format [None]: 

```sh
cat ~/.aws/credentials
```
[sts]
aws_access_key_id = KEY_HERE
aws_secret_access_key = KEY_HERE

# Check current CLI user
```sh
aws sts get-caller-identity
```
{
    "UserId": "KEY_HERE"
    "Account": "425560113058",
    "Arn": "arn:aws:iam::425560113058:user/sts-testuser"
}

# Use sts profile and check S3 access
```sh
aws sts get-caller-identity --profile sts
```
{
    "UserId": "KEY_HERE",
    "Account": "425560113058",
    "Arn": "arn:aws:iam::425560113058:user/sts-testuser"
}

```sh
aws s3 ls --profile sts
```
aws: [ERROR]: An error occurred (AccessDenied) when calling the ListBuckets operation: User: arn:aws:iam::425560113058:user/sts-testuser is not authorized to perform: s3:ListAllMyBuckets because no identity-based policy allows the s3:ListAllMyBuckets action

# Create S3 bucket, role and managed policy for access to the resource
template.yaml

# Attach a policy so the user can assume a role
```sh
aws iam put-user-policy \
    --user-name sts-testuser \
    --policy-name AssumeStsPolicy \
    --policy-document file://policy.json
```

# Assume role to get temporary credentials
```sh
aws sts assume-role \
    --role-arn arn:aws:iam::425560113058:role/sts-stack-CustomRole-thjmNYtG4ws5 \
    --role-session-name sts-session \
    --profile sts
```
{
    "Credentials": {
        "AccessKeyId": "KEY_HERE",
        "SecretAccessKey": "KEY_HERE",
        "SessionToken": "KEY_HERE",
        "Expiration": "2026-05-15T15:31:30+00:00"
    },
    "AssumedRoleUser": {
        "AssumedRoleId": "ROLE_ID:sts-session",
        "Arn": "arn:aws:sts::425560113058:assumed-role/sts-stack-CustomRole-thjmNYtG4ws5/sts-session"
    }
}

# Add temporary credentials to ~/.aws/credentials
```sh
vim ~/.aws/credentials
```
[sts]
aws_access_key_id = KEY_HERE
aws_secret_access_key = KEY_HERE
[assumed]
aws_access_key_id = KEY_HERE
aws_secret_access_key = KEY_HERE

# Use assumed profile credentials to access and place file in S3 bucket
```sh
echo "hello world" > myfile.txt
aws s3 cp myfile.txt s3://yashj123456-sts
aws s3 ls s3://yashj123456-sts --profile assumed
```
upload: ./myfile.txt to s3://yashj123456-sts/myfile.txt 
2026-05-15 15:38:33         12 myfile.txt


# Cleanup
```sh
aws s3 rm s3://yashj123456-sts --recursive
aws s3 rb s3://yashj123456-sts
aws cloudformation delete-stack --stack-name sts-stack
aws iam delete-user-policy \
    --user-name sts-testuser \
    --policy-name AssumeStsPolicy
aws iam delete-access-key \
    --access-key-id KEY_HERE \
    --user-name sts-testuser
aws iam delete-user --user-name sts-testuser
```