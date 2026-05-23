# Create a S3 bucket for the static website bucket
```sh
aws s3 mb s3://yashj123456-cors
```
make_bucket: yashj123456-cors

# Remove block public access bucket policy for the static website bucket
```sh
aws s3api put-public-access-block \
    --bucket yashj123456-cors \
    --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"
```

# Create a bucket policy for the static website bucket
```sh
aws s3api put-bucket-policy \
    --bucket yashj123456-cors \
    --policy file://policy.json
```

# Enable static web hosting for the static website bucket
```sh
aws s3 website s3://yashj123456-cors \
    --index-document index.html \
    --error-document error.html
```

# Upload index.html to static website bucket
```sh
aws s3 cp index.html s3://yashj123456-cors
aws s3 cp error.html s3://yashj123456-cors
```
upload: ./index.html to s3://yashj123456-cors/index.html  
upload: ./error.html to s3://yashj123456-cors/error.html

# Get website endpoint for S3 bucket
http://yashj123456-cors.s3-website.eu-west-2.amazonaws.com
http://yashj123456-cors.s3-website.eu-west-2.amazonaws.com/error.html

# Create API gateway with mock integration response 
via AWS console

```sh
curl -X POST -H "Content-Type: application/json" https://4kvoybi7qi.execute-api.eu-west-2.amazonaws.com/prod/hello
```

# Add CORS resource to index.html (POST request via REST API gateway)
```js
    <script>
        const xhr = new XMLHttpRequest();
        xhr.open("POST", "https://4kvoybi7qi.execute-api.eu-west-2.amazonaws.com/prod/hello", true);
        // Send the proper header information along with the request
        xhr.setRequestHeader("Content-Type", "application/json");
        xhr.onreadystatechange = () => {
        // Call a function when the state changes.
        if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
            // Request finished. Do processing here.
            const results = JSON.parse(this.responseText);
            console.log('results','results')
        }
        };
        xhr.send();
        // xhr.send(document);
    </script>
```

# Try to visit the static website url and monitor network via dev tools
Access to XMLHttpRequest at 'https://4kvoybi7qi.execute-api.eu-west-2.amazonaws.com/prod/hello' from origin 'http://yashj123456-cors.s3-website.eu-west-2.amazonaws.com' has been blocked by CORS policy: Response to preflight request doesn't pass access control check: No 'Access-Control-Allow-Origin' header is present on the requested resource.

# Apply a CORS policy to the bucket
```sh
aws s3api put-bucket-cors \
    --bucket yashj123456-cors \
    --cors-configuration file://cors.json
```

# Enable CORS via AWS API gateway for /hello resource path
via AWS console

# Try to visit the static website url and monitor network via dev tools
No errors

# Cleanup
```sh
aws s3 rm s3://yashj123456-cors --recursive
aws s3 rb s3://yashj123456-cors
```
delete API gateway