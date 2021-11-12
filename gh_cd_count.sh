#!/bin/sh

#
# Requires curl, jq, sort, uniq
# Tested on Ubuntu Linux 5.4.72-microsoft-standard-WSL2
# Shell script returning the list and number of unique authors in the last 90 days on the cx-flow cx github repo
#
#

DATEMINUS90DAYS=$(expr `date +%s` - 7776000)

echo List of commit authors since `date -d @${DATEMINUS90DAYS}`

AUTHLIST=$(curl -s -G "https://api.github.com/repos/checkmarx-ltd/cx-flow/commits" | jq ".[] | .commit.author | select (.date | fromdateiso8601 > $DATEMINUS90DAYS) | .name" | sort | uniq)

echo $AUTHLIST

echo $AUTHLIST | sed -e "s/\" \"/\*\*\*/g" | sed -e "s/ //g" | sed -e "s/\*\*\*/ /g" | wc -w
