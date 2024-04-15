#!/bin/bash

if [[ -z "${GITHUB_RUN_ID}" ]];then
    source .env
fi

if [[ -z "${SUBREDDIT}" ]];then
    SUBREDDIT=test
fi

TOKEN=$(curl -X POST -A 'User agent' -d "grant_type=password&username=$REDDIT_USERNAME&password=$REDDIT_PASSWORD" --user "$CLIENT_ID:$CLIENT_SECRET" https://www.reddit.com/api/v1/access_token | jq -r .access_token)
TEXT=$(./run.rb)

curl -i -H "Authorization: Bearer $TOKEN" -A "User agent" -H "Content-Type: application/x-www-form-urlencoded" -X POST \
  --data-urlencode "title=Testing again" \
  --data-urlencode "kind=self" \
  --data-urlencode "sr=$SUBREDDIT" \
  --data-urlencode "resubmit=true" \
  --data-urlencode "sendreplies=true" \
  --data-urlencode "text=$TEXT" \
  https://oauth.reddit.com/api/submit
