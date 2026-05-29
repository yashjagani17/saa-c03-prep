# Deploy SNS + Lambda + Subscriber via AWS SAM
```sh
sam build \
  --template-file template.yaml
```
Build Succeeded

Built Artifacts  : .aws-sam/build
Built Template   : .aws-sam/build/template.yaml

```sh
sam deploy \
  --stack-name sns-stack \
  --capabilities CAPABILITY_IAM
```
Waiting for changeset to be created..
Changeset created successfully. arn:aws:cloudformation:eu-west-2:425560113058:changeSet/samcli-deploy1780068297/af4c217a-2c8f-4cef-816f-2badef48aea8
Successfully created/updated stack - sns-stack in None

# Publish message to SNS
```sh
aws sns publish \
  --topic-arn arn:aws:sns:eu-west-2:425560113058:sns-stack-SNSTopic-CLR6uhStYtsw \
  --message-structure json \
  --message '{"default": "{\"first_name\": \"Yash\", \"last_name\": \"Jagani\"}"}'
```

# Check CloudWatch logs for Lambda execution
```sh
aws logs tail /aws/lambda/sns-stack-Lambda-N27VhJ3h88Dx --region eu-west-2
```
2026-05-29T16:16:03.889000+00:00 2026/05/29/[$LATEST]a13a7524e81d44ea80185a45f5511e2b INIT_START Runtime Version: python:3.12.mainlinev2.v11	Runtime Version ARN: arn:aws:lambda:eu-west-2::runtime:0eb6fb00a97c1a17d2e3014b04c79bfc9bea4301466439e3458f985dc75cadcc
2026-05-29T16:16:03.969000+00:00 2026/05/29/[$LATEST]a13a7524e81d44ea80185a45f5511e2b START RequestId: 188dfe6c-2c2c-443e-9ba1-1fbd1da533f9 Version: $LATEST
2026-05-29T16:16:03.970000+00:00 2026/05/29/[$LATEST]a13a7524e81d44ea80185a45f5511e2b Log this for me. Hello Yash Jagani!
2026-05-29T16:16:03.972000+00:00 2026/05/29/[$LATEST]a13a7524e81d44ea80185a45f5511e2b END RequestId: 188dfe6c-2c2c-443e-9ba1-1fbd1da533f9
2026-05-29T16:16:03.972000+00:00 2026/05/29/[$LATEST]a13a7524e81d44ea80185a45f5511e2b REPORT RequestId: 188dfe6c-2c2c-443e-9ba1-1fbd1da533f9	Duration: 1.73 ms	Billed Duration: 80 ms	Memory Size: 128 MB	Max Memory Used: 36 MB	Init Duration: 77.45 ms

# Cleanup
```sh
sam delete \
  --stack-name sns-stack
```