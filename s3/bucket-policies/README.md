# Create S3 bucket
```sh
aws s3 mb s3://yashj123456-bucket-policy
```

# Add policy to allow second AWS account to list bucket + get object
```sh
aws s3api put-bucket-policy --bucket yashj123456-bucket-policy --policy file://policy.json
```

# Get bucket policy
```sh
aws s3api get-bucket-policy --bucket yashj123456-bucket-policy
```
{
    "Policy": "{\"Version\":\"2008-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"arn:aws:iam::366339682068:root\"},\"Action\":[\"s3:ListBucket\",\"s3:GetObject\",\"s3:PutObject\"],\"Resource\":[\"arn:aws:s3:::yashj123456-bucket-policy\",\"arn:aws:s3:::yashj123456-bucket-policy/*\"]}]}"
}

# Create a file
```sh
echo "hello world" > myfile.txt
```

# Attempt to upload a file to S3 bucket via CloudShell on second AWS account
```sh
aws s3 cp myfile.txt s3://yashj123456-bucket-policy
```
upload: ./myfile.txt to s3://yashj123456-bucket-policy/myfile.txt 

# List files in S3 bucket via CloudShell on second AWS account
```sh
aws s3 ls s3://yashj123456-bucket-policy
```
2026-05-13 10:39:29         12 myfile.txt

# Cleanup
```sh
aws s3 rm s3://yashj123456-bucket-policy --recursive
aws s3 rb s3://yashj123456-bucket-policy
```