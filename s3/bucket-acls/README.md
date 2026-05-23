# Create S3 bucket
```sh
aws s3 mb s3://yashj123456-acl
```

# Change bucket ownership controls to enable ACLs
```sh
aws s3api put-bucket-ownership-controls \
    --bucket yashj123456-acl \
    --ownership-controls="Rules=[{ObjectOwnership=BucketOwnerPreferred}]"
```

# Add ACL to allow another AWS account full access to the S3 bucket
```sh
aws s3api put-bucket-acl \
    --bucket yashj123456-acl \
    --grant-full-control id=3be81296788baadfccd9366ef3f30299b240ddba19bfc011c543be2671e845fb,id=b324a7503736da11eb477578789cb45ecaed65e9d8874d4b157f3fd2cc1ec3ad
```

# Retrieve ACLs of S3 bucket
```sh
aws s3api get-bucket-acl \
    --bucket yashj123456-acl
```
{
    "Owner": {
        "ID": "3be81296788baadfccd9366ef3f30299b240ddba19bfc011c543be2671e845fb"
    },
    "Grants": [
        {
            "Grantee": {
                "ID": "3be81296788baadfccd9366ef3f30299b240ddba19bfc011c543be2671e845fb",
                "Type": "CanonicalUser"
            },
            "Permission": "FULL_CONTROL"
        },
        {
            "Grantee": {
                "ID": "b324a7503736da11eb477578789cb45ecaed65e9d8874d4b157f3fd2cc1ec3ad",
                "Type": "CanonicalUser"
            },
            "Permission": "FULL_CONTROL"
        }
    ]
}

# Create a file in AWS CloudShell on second AWS account
```sh
echo "hello world" > myfile.txt
```

# Upload file to S3 from second AWS account
```sh
aws s3 cp myfile.txt s3://yashj123456-acl
```
upload: ./myfile.txt to s3://yashj123456-acl/myfile.txt   

# List files in S3 bucket
```sh
aws s3 ls s3://yashj123456-acl
```
2026-05-13 10:14:05         12 myfile.txt

# Cleanup
```sh
aws s3 rm s3://yashj123456-acl --recursive
aws s3 rb s3://yashj123456-acl
```