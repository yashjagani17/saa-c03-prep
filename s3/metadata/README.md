# Create S3 bucket
```sh
aws s3 mb s3://yashj123456-metadata
```

# Create a file
```sh
echo "hello world" > myfile.txt
```

# Upload file to S3 bucket with metadata
```sh
aws s3api put-object \
  --bucket yashj123456-metadata \
  --key myfile.txt \
  --body myfile.txt \
  --metadata hello=world
```
{
    "ETag": "\"5eb63bbbe01eeed093cb22bb8f5acdc3\"",
    "ChecksumCRC64NVME": "jSnVw/bqjr4=",
    "ChecksumType": "FULL_OBJECT",
    "ServerSideEncryption": "AES256"
}

# Get object using head from S3 bucket
```sh
aws s3api head-object \
  --bucket yashj123456-metadata \
  --key myfile.txt
```
{
    "AcceptRanges": "bytes",
    "LastModified": "2026-05-12T16:08:40+00:00",
    "ContentLength": 11,
    "ETag": "\"5eb63bbbe01eeed093cb22bb8f5acdc3\"",
    "ContentType": "binary/octet-stream",
    "ServerSideEncryption": "AES256",
    "Metadata": {
        "hello": "world"
    }
}

# Cleanup
```sh
aws s3 rm s3://yashj123456-metadata --recursive
aws s3 rb s3://yashj123456-metadata
```