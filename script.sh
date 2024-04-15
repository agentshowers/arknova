#!/bin/bash

if [[ -z "${GITHUB_RUN_ID}" ]];then
    source .env
fi

#TOKEN=$(curl -X POST -A 'User agent' -d "grant_type=password&username=$REDDIT_USERNAME&password=$REDDIT_PASSWORD" --user "$CLIENT_ID:$CLIENT_SECRET" https://www.reddit.com/api/v1/access_token | jq -r .access_token)

./run.rb > post.md
cat post.md
