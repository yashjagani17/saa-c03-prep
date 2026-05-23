# Create S3 bucket
```sh
aws s3 mb s3://yashj123456-encryption-client
```

# Use ruby AWS SDK for client side encrpytion and decrpytion
```sh
bundle install
bundle exec ruby encrypt.rb
```
PUT
{:expiration=>nil, :etag=>"\"3df83b1fc6b8d1ed467a1f2e1f7c0be9\"", :checksum_crc32=>"zcQoTA==", :checksum_crc32c=>nil, :checksum_crc64nvme=>nil, :checksum_sha1=>nil, :checksum_sha256=>nil, :checksum_sha512=>nil, :checksum_md5=>nil, :checksum_xxhash64=>nil, :checksum_xxhash3=>nil, :checksum_xxhash128=>nil, :checksum_type=>"FULL_OBJECT", :server_side_encryption=>"AES256", :version_id=>nil, :sse_customer_algorithm=>nil, :sse_customer_key_md5=>nil, :ssekms_key_id=>"[FILTERED]", :ssekms_encryption_context=>"[FILTERED]", :bucket_key_enabled=>nil, :size=>nil, :request_charged=>nil}
GET WITH KEY
hello world
WITHOUT KEY
�p�"��@V��BW+6�#c֧�K`i&

# Cleanup
```sh
aws s3 rm s3://yashj123456-encryption-client --recursive
aws s3 rb s3://yashj123456-encryption-client
```