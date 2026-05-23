# Create S3 bucket
```sh
aws s3api create-bucket \
  --bucket yashj-checksum123456 \
  --region eu-west-2 \
  --create-bucket-configuration LocationConstraint=eu-west-2
```

# Create a file
```sh
echo "hello world" > myfile.txt
```

# Generate checksum using SHA256
```sh
openssl sha256 myfile.txt 
SHA2-256(myfile.txt)= b94d27b9934d3e08a52e52d7da7dabfac484efe37a5380ee9088f7ace2efcde9
```

# Convert checksum into base64
```sh
echo openssl dgst -sha256 -binary myfile.txt | base64
uU0nuZNNPgilLlLX2n2r+sSE7+N6U4DukIj3rOLvzek=
```

# Upload to S3
```sh
aws s3api put-object \
  --bucket yashj-checksum123456 \
  --key myfile.txt \
  --body myfile.txt \
  --checksum-algorithm SHA256 \
  --checksum-sha256 $(openssl dgst -sha256 -binary myfile.txt | base64)
```
{
    "ETag": "\"5eb63bbbe01eeed093cb22bb8f5acdc3\"",
    "ChecksumSHA256": "uU0nuZNNPgilLlLX2n2r+sSE7+N6U4DukIj3rOLvzek=",
    "ChecksumType": "FULL_OBJECT",
    "ServerSideEncryption": "AES256"
}

# Cleanup
```sh
aws s3 rm s3://yashj-checksum123456 --recursive
aws s3 rb s3://yashj-checksum123456
```