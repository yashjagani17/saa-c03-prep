# Create EC2 instance with a public ipv4 address via management console

# Generate new SSH public and private keys
```sh
ssh-keygen -t rsa -f my_key
```
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in my_key
Your public key has been saved in my_key.pub
The key fingerprint is:
SHA256:KJRgz3L23tqkdyp43QQif+nG26k+LDlka2lVuBeYesY yash@ubuntu
The key's randomart image is:
+---[RSA 3072]----+
|  o              |
| . + .           |
|  . B    +       |
|   =....= o      |
|    .oo+S= .     |
|     o=.E o      |
|     +.&o+       |
|    . @=O.o.     |
|     +oB**o      |
+----[SHA256]-----+

# Push the public SSH key to the instance
```sh
aws ec2-instance-connect send-ssh-public-key \
    --region eu-west-2 \
    --availability-zone eu-west-2c \
    --instance-id i-09301b2af8d40f503 \
    --instance-os-user ec2-user \
    --ssh-public-key file://my_key.pub
```
{
    "RequestId": "f11aa1f3-ed4a-4efd-b945-5fcd9cfe12d5",
    "Success": true
}

# Set SSH key to provide only the owner with read-only access (required)
```sh
chmod 400 my_key
```

# Connect to EC2 instance via EC2 connect
```sh
ssh -i my_key ec2-user@ec2-35-179-133-0.eu-west-2.compute.amazonaws.com
```
   ,     #_
   ~\_  ####_        Amazon Linux 2023
  ~~  \_#####\
  ~~     \###|
  ~~       \#/ ___   https://aws.amazon.com/linux/amazon-linux-2023
   ~~       V~' '->
    ~~~         /
      ~~._.   _/
         _/ _/
       _/m/'
ec2-user@ec2-35-179-133-0.eu-west-2.compute.amazonaws.com: Permission denied (publickey,gssapi-keyex,gssapi-with-mic).
[ec2-user@ip-172-31-15-100 ~]$ whoami
ec2-user
