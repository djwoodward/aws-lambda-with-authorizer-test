openssl genrsa -out private-key.pem 2048
openssl rsa -in private-key.pem -pubout -out public-key.pem

# Store public key in SSM
aws ssm put-parameter \
--type String \
--name '/param/test/public-key' \
--overwrite \
--region us-east-1 \
--value \
"$(cat public-key.pem)"

# Encrypt and store private key in SSM
aws ssm put-parameter \
--type SecureString \
--name '/param/test/private-key' \
--overwrite \
--region us-east-1 \
--value \
"$(cat private-key.pem)"
