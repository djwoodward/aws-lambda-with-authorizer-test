#!/bin/zsh

# openssl genrsa -out private-key.pem 2048
# openssl rsa -in private-key.pem -pubout -out public-key.pem
EXPIRES_PLUS_SECONDS=$1
ISSUER=$2
SUB=$3
PRIVS=$4

NOW=$(date +%s) || exit 1
EXPIRES=$((NOW + EXPIRES_PLUS_SECONDS)) || exit 1

JWT_PAYLOAD=$(cat <<-END
{
  "privs": $PRIVS
}
END
)

jwt encode --alg RS256 \
--secret @private-key.pem \
--iss "$ISSUER" \
--sub "SUB" \
-e "$EXPIRES" \
"$JWT_PAYLOAD" \
|| exit 1

## jwt decode --alg RS256 --secret @public-key.pem <jwt>