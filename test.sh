#!/bin/zsh

URL=$1
TOKEN=$2

echo Making call to "$URL"
curl "$URL" -H "Authorization: Bearer $TOKEN" -i