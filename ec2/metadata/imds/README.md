# Create EC2 instance with SSM and IMDSv1 and IMDSv2 allowed via management console

# curl to get public ipv4 address of EC2 instance
```sh
curl http://169.254.169.254/latest/meta-data/public-ipv4
```
18.130.117.149

```sh
curl -I http://169.254.169.254/latest/meta-data/public-ipv4
```
HTTP/1.1 200 OK
Content-Type: text/plain
Accept-Ranges: none
Last-Modified: Tue, 26 May 2026 12:53:28 GMT
Content-Length: 14
Date: Tue, 26 May 2026 13:04:14 GMT
Server: EC2ws
Connection: close


# Modify instance metadata options and set IMDSv2 to required via management console

# curl to get public ipv4 address of EC2 instance
```sh
curl http://169.254.169.254/latest/meta-data/public-ipv4
```

curl -I http://169.254.169.254/latest/meta-data/public-ipv4
```
HTTP/1.1 401 Unauthorized
Content-Length: 0
Date: Tue, 26 May 2026 13:03:37 GMT
Server: EC2ws
Connection: close
Content-Type: text/plain

# Generate a token
```sh
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    56 100    56   0     0 15238     0  --:--:-- --:--:-- --:--:-- 18666

```sh
echo $TOKEN
```
AQAEABEaO6gPp-PwhrXyIm8_H-Dx1gIIItmX-T3Ij2LObNJiumymPQ==

# Use token to generate EC2 public ipv4 meta-data
```sh
curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/public-ipv4
```
18.130.117.149

```sh
curl -I -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/public-ipv4
```
HTTP/1.1 200 OK
X-Aws-Ec2-Metadata-Token-Ttl-Seconds: 21243
Content-Type: text/plain
Accept-Ranges: none
Last-Modified: Tue, 26 May 2026 12:53:28 GMT
Content-Length: 14
Date: Tue, 26 May 2026 13:12:55 GMT
Server: EC2ws
Connection: close

# Cleanup via management console