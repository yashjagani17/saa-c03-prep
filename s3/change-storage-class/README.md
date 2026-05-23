# Create S3 bucket
```sh
aws s3 mb s3://yashj123456-storage-class
```

# Create file
```sh
echo "hello world" > myfile.txt
```

# Upload file to S3 bucket specifying storage class
```sh
aws s3 cp myfile.txt s3://yashj123456-storage-class --storage-class STANDARD_IA
```

# Cleanup
```sh
aws rm s3://yashj123456-storage-class --recursive
aws rb s3://yashj123456-storage-class
```