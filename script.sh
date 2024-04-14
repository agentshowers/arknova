curl -X POST -A 'User agent' -d 'grant_type=password&username=<usr>&password=<pwd>' --user '<id>:<secret>' https://www.reddit.com/api/v1/access_token

jq '.access_token'

