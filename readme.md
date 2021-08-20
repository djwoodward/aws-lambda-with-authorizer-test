# Lambda Authorizer Test

### Scripts

`udate_keys_in_ssm.sh`

Creates a new RSA key pair and uploads to ssm params '/param/test/public-key', '/param/test/private-key'

`udate_keys_in_ssm.sh <secondsToExpire> <clientName> <privs>`

```bash
# Create token that expires in 600s:
JWT=$(sh create_jwt.sh 600 your_email@email.com 'subscriber' '["priv1", "priv2"]')
```

Creates a basic JWT using the private-key.pem 

`deploy.sh <stackName> <s3bucketName>`

Deploys the template.yaml stack

`test.sh <url> <jwt>`

Curls the server with the token provided.
```bash
sh test.sh https://..aws../default/echo $JWT
```

# Resources
https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-use-lambda-authorizer.html

https://betterprogramming.pub/how-to-store-your-aws-lambda-secrets-cheaply-without-compromising-scalability-or-security-d3e8a250f12c

https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-control-access-to-api.html

https://docs.aws.amazon.com/apigateway/latest/developerguide/permissions.html

https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-resource-policies.html