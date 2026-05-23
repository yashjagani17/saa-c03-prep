# Create a S3 bucket
```sh
aws s3 mb s3://yashj123456-customer-encryption
```
make_bucket: yashj123456-customer-encryption

# Unblock SSE-C bucket encryption type
```sh
aws s3api put-bucket-encryption \
    --bucket yashj123456-customer-encryption \
    --server-side-encryption-configuration file://sse-c.json
```

# Create a file
```sh
echo "hello world" > myfile.txt
```

# Generate AES256 customer side encryption key
https://www.scaleway.com/en/docs/object-storage/api-cli/enable-sse-c/

```sh
# customer key
openssl rand -out ssec.key 32
```

# Upload with SSE-C encryption
```sh
aws s3api put-object \
    --bucket yashj123456-customer-encryption \
    --key myfile.txt \
    --body myfile.txt \
    --sse-customer-algorithm AES256 \
    --sse-customer-key fileb://sse-c.key \
    --sse-customer-key-md5 $(openssl dgst -md5 -binary sse-c.key | base64)
```
{
    "ETag": "\"8bca4604ed3cbec683ad2b3ea3f66fbd\"",
    "ChecksumCRC64NVME": "D3gOhIHSoh8=",
    "ChecksumType": "FULL_OBJECT",
    "SSECustomerAlgorithm": "AES256",
    "SSECustomerKeyMD5": "KLdqwD0sBqwMXvXrHSKnJQ=="
}

# Attempt to get the file without a key
```sh
aws s3api head-object \
    --bucket yashj123456-customer-encryption \
    --key myfile.txt
```
aws: [ERROR]: An error occurred (400) when calling the HeadObject operation: Bad Request

# Download the file (using customer algorithm + key)
```sh
aws s3api get-object \
    --bucket yashj123456-customer-encryption \
    --key myfile.txt \
    --sse-customer-algorithm AES256 \
    --sse-customer-key fileb://sse-c.key \
    --sse-customer-key-md5 $(openssl dgst -md5 -binary sse-c.key | base64) \
    download.txt
```
{
    "AcceptRanges": "bytes",
    "LastModified": "2026-05-13T15:38:20+00:00",
    "ContentLength": 12,
    "ETag": "\"8bca4604ed3cbec683ad2b3ea3f66fbd\"",
    "ChecksumCRC64NVME": "D3gOhIHSoh8=",
    "ChecksumType": "FULL_OBJECT",
    "ContentType": "binary/octet-stream",
    "Metadata": {},
    "SSECustomerAlgorithm": "AES256",
    "SSECustomerKeyMD5": "KLdqwD0sBqwMXvXrHSKnJQ=="
}

# Cleanup
```sh
aws s3 rm s3://yashj123456-customer-encryption --recursive
aws s3 rb s3://yashj123456-customer-encryption
```