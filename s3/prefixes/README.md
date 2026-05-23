# Create S3 bucket
```sh
aws s3 mb s3://yashj123456-prefixes
```

# Create virtual folders in bucket to limit (1024 bytes)
Lorem/ipsum/dolor/sit/amet2/consectetur/adipiscing/elit1/Pellentesque/nec/sapien/rutrum2/ultrices/mi/vel2/lobortis/lorem1/Nullam/eget/varius/nulla1/Nullam/porttitor/felis/sed/placerat/condimentum1/Fusce/sagittis/nibh/nibh2/in/commodo/urna/facilisis/non1/Nam/mollis/nisi/pharetra/interdum/dignissim1/Duis/in/feugiat/libero2/in/facilisis/dui1/Phasellus/vel/nunc/at/nunc/semper/congue1/Fusce/pulvinar/felis/sed/convallis/sodales1/Proin/volutpat/eu/mi/non/consectetur1/Quisque/nec/neque/cursus2/feugiat/turpis/sed2/vestibulum/ipsum1/In/sit/amet/ex/et/lacus/vestibulum/gravida1/Praesent/fermentum/ipsum/nec/viverra/feugiat1/Curabitur/viverra/augue/ac/nunc/ullamcorper/efficitur1/Nunc/vitae/lacinia/dui2/vitae/condimentum/libero1Nunc/vel/augue/dictum2/convallis/orci/ac2/varius/libero1/Nunc/eros/mi2/malesuada/vel/ante/nec2/dapibus/condimentum/leo1/Vestibulum/ante/ipsum/primis/in/faucibus/orci/luctus/et/ultrices/posuere/cubilia/curae;/Suspendisse/vitae/nibh/est1/Nullam/fermentum/condimentum/turpis2/ac/vehicula/tellus/pharetra1

```sh
aws s3api put-object \
  --bucket yashj123456-prefixes \
  --key Lorem/ipsum/dolor/sit/amet2/consectetur/adipiscing/elit1/Pellentesque/nec/sapien/rutrum2/ultrices/mi/vel2/lobortis/lorem1/Nullam/eget/varius/nulla1/Nullam/porttitor/felis/sed/placerat/condimentum1/Fusce/sagittis/nibh/nibh2/in/commodo/urna/facilisis/non1/Nam/mollis/nisi/pharetra/interdum/dignissim1/Duis/in/feugiat/libero2/in/facilisis/dui1/Phasellus/vel/nunc/at/nunc/semper/congue1/Fusce/pulvinar/felis/sed/convallis/sodales1/Proin/volutpat/eu/mi/non/consectetur1/Quisque/nec/neque/cursus2/feugiat/turpis/sed2/vestibulum/ipsum1/In/sit/amet/ex/et/lacus/vestibulum/gravida1/Praesent/fermentum/ipsum/nec/viverra/feugiat1/Curabitur/viverra/augue/ac/nunc/ullamcorper/efficitur1/Nunc/vitae/lacinia/dui2/vitae/condimentum/libero1Nunc/vel/augue/dictum2/convallis/orci/ac2/varius/libero1/Nunc/eros/mi2/malesuada/vel/ante/nec2/dapibus/condimentum/leo1/Vestibulum/ante/ipsum/primis/in/faucibus/orci/luctus/et/ultrices/posuere/cubilia/curae3/Suspendisse/vitae/nibh/est1/Nullam/fermentum/condimentum/turpis2/ac/vehicula/tellus/pharetra/
```
{
    "ETag": "\"d41d8cd98f00b204e9800998ecf8427e\"",
    "ChecksumCRC64NVME": "AAAAAAAAAAA=",
    "ChecksumType": "FULL_OBJECT",
    "ServerSideEncryption": "AES256"
}

# List S3 bucket objects
```sh
aws s3api list-objects-v2 --bucket yashj123456-prefixes
```
{
    "Contents": [
        {
            "Key": "Lorem/ipsum/dolor/sit/amet2/consectetur/adipiscing/elit1/Pellentesque/nec/sapien/rutrum2/ultrices/mi/vel2/lobortis/lorem1/Nullam/eget/varius/nulla1/Nullam/porttitor/felis/sed/placerat/condimentum1/Fusce/sagittis/nibh/nibh2/in/commodo/urna/facilisis/non1/Nam/mollis/nisi/pharetra/interdum/dignissim1/Duis/in/feugiat/libero2/in/facilisis/dui1/Phasellus/vel/nunc/at/nunc/semper/congue1/Fusce/pulvinar/felis/sed/convallis/sodales1/Proin/volutpat/eu/mi/non/consectetur1/Quisque/nec/neque/cursus2/feugiat/turpis/sed2/vestibulum/ipsum1/In/sit/amet/ex/et/lacus/vestibulum/gravida1/Praesent/fermentum/ipsum/nec/viverra/feugiat1/Curabitur/viverra/augue/ac/nunc/ullamcorper/efficitur1/Nunc/vitae/lacinia/dui2/vitae/condimentum/libero1Nunc/vel/augue/dictum2/convallis/orci/ac2/varius/libero1/Nunc/eros/mi2/malesuada/vel/ante/nec2/dapibus/condimentum/leo1/Vestibulum/ante/ipsum/primis/in/faucibus/orci/luctus/et/ultrices/posuere/cubilia/curae3/Suspendisse/vitae/nibh/est1/Nullam/fermentum/condimentum/turpis2/ac/vehicula/tellus/pharetra/",
            "LastModified": "2026-05-12T15:56:53+00:00",
            "ETag": "\"d41d8cd98f00b204e9800998ecf8427e\"",
            "ChecksumAlgorithm": [
                "CRC64NVME"
            ],
            "ChecksumType": "FULL_OBJECT",
            "Size": 0,
            "StorageClass": "STANDARD"
        }
    ],
    "RequestCharged": null,
    "Prefix": ""
}

# Create file 
```sh
echo "hello world" > myfile.txt
```

# Attempt to upload file to end of prefix in S3 bucket
```sh
aws s3api put-object --bucket yashj123456-prefixes \
  --key Lorem/ipsum/dolor/sit/amet2/consectetur/adipiscing/elit1/Pellentesque/nec/sapien/rutrum2/ultrices/mi/vel2/lobortis/lorem1/Nullam/eget/varius/nulla1/Nullam/porttitor/felis/sed/placerat/condimentum1/Fusce/sagittis/nibh/nibh2/in/commodo/urna/facilisis/non1/Nam/mollis/nisi/pharetra/interdum/dignissim1/Duis/in/feugiat/libero2/in/facilisis/dui1/Phasellus/vel/nunc/at/nunc/semper/congue1/Fusce/pulvinar/felis/sed/convallis/sodales1/Proin/volutpat/eu/mi/non/consectetur1/Quisque/nec/neque/cursus2/feugiat/turpis/sed2/vestibulum/ipsum1/In/sit/amet/ex/et/lacus/vestibulum/gravida1/Praesent/fermentum/ipsum/nec/viverra/feugiat1/Curabitur/viverra/augue/ac/nunc/ullamcorper/efficitur1/Nunc/vitae/lacinia/dui2/vitae/condimentum/libero1Nunc/vel/augue/dictum2/convallis/orci/ac2/varius/libero1/Nunc/eros/mi2/malesuada/vel/ante/nec2/dapibus/condimentum/leo1/Vestibulum/ante/ipsum/primis/in/faucibus/orci/luctus/et/ultrices/posuere/cubilia/curae3/Suspendisse/vitae/nibh/est1/Nullam/fermentum/condimentum/turpis2/ac/vehicula/tellus/pharetra/myfile.txt
```
aws: [ERROR]: An error occurred (KeyTooLongError) when calling the PutObject operation: Your key is too long

Additional error details:
Size: 1034
MaxSizeAllowed: 1024

# Cleanup
```sh
aws s3 rm s3://yashj123456-prefixes --recursive
aws s3 rb s3://yashj123456-prefixes
```