#!/bin/bash

set -e

if [[ -z "${GITHUB_RUN_ID}" ]];then
    source .env
fi

if [[ -z "${SUBREDDIT}" ]];then
    SUBREDDIT=test
fi

TEXT=$(cat post.md)

echo "Getting token"
TOKEN=$(
  curl --silent --show-error --fail -X POST -A 'User agent' \
  -d "grant_type=password&username=$REDDIT_USERNAME&password=$REDDIT_PASSWORD" \
  --user "$REDDIT_CLIENT_ID:$REDDIT_CLIENT_SECRET" https://www.reddit.com/api/v1/access_token \
  | jq -r .access_token
)

if [[ -z "${TOKEN}" ]];then
    exit 1
fi

echo "Posting to reddit"
curl --silent --output /dev/null --show-error --fail -i \
  -H "Authorization: Bearer $TOKEN" -A "User agent" -H "Content-Type: application/x-www-form-urlencoded" -X POST \
  --data-urlencode "title=Starting hand of the week" \
  --data-urlencode "kind=self" \
  --data-urlencode "sr=$SUBREDDIT" \
  --data-urlencode "resubmit=true" \
  --data-urlencode "sendreplies=true" \
  --data-urlencode "text=$TEXT" \
  https://oauth.reddit.com/api/submit
