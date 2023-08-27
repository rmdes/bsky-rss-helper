# bsky-rss-helper
a few scripts to help handle bsky.rss RSS news bots
this is meant to be used with [bsky.rss](https://github.com/milanmdev/bsky.rss)

- down.sh to down all the newsbots
- up.sh to up all the newsbots
- set_config.sh to set/overwrite config.json values to default (master defined inside this file)
- up_config.sh to update to default values without overwriting exisiting ones
- update.image.sh to update each docker-compose.yml image field with the latest docker image.