# Create a S3 bucket
```sh
aws s3 mb s3://yashj123456--kmsencryption
```
make_bucket: yashj123456-kms-encryption

# Enable SSE-KMS bucket encryption using the default S3 encryption key arn
```sh
aws s3api put-bucket-encryption \
    --bucket yashj123456-kms-encryption \
    --server-side-encryption-configuration file://sse-kms.json
```

# Create a file
```sh
echo "hello world" > myfile.txt
```

# Upload the file to S3 bucket
```sh
aws s3 cp myfile.txt s3://yashj123456-kms-encryption
```
upload: ./myfile.txt to s3://yashj123456-kms-encryption/myfile.txt


# Upload with SSE-KMS encryption
```sh
aws s3api put-object \
    --bucket yashj123456-kms-encryption
    --key myfile.txt \
    --body myfile.txt \
    # ("BucketKeyEnabled": true in sse-kms.json ~> SSE-KMS applies to all objects in the bucket by default)
    # --server-side-encryption aws:kms \
    # --ssekms-key-id 957b9288-dd53-482e-8984-620dbb5a61d7
```

# Download the file (we have the decryption role for AWS KMS)
```sh
aws s3api get-object \
    --bucket yashj123456-kms-encryption \
    --body myfile.txt \
    download.txt

```

# Cleanup
```sh
aws s3 rm s3://yashj123456-kms-encryption --recursive
aws s3 rb s3://yashj123456-kms-encryption
```