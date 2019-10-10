#!/bin/bash

api=""
year=$(date +'%Y')
month=$(date +'%m')

fdns=$(curl -H "X-Api-Key: $api" "https://us.api.insight.rapid7.com/opendata/studies/sonar.fdns_v2/" --silent | jq -r '.sonarfile_set[]' | grep -m 1 -E "$year-$month-[0-3]{1}[0-9]{1}-[0-9]{10}-fdns_any.json.gz")
f_link=$(curl -H "X-Api-Key: $api" "https://us.api.insight.rapid7.com/opendata/studies/sonar.fdns_v2/$fdns/download/" --silent | jq '.url' | sed 's/\"//g')
wget -bqc "$f_link" -O ~/recon/data/fdns_any.json.gz

cname=$(curl -H "X-Api-Key: $api" "https://us.api.insight.rapid7.com/opendata/studies/sonar.fdns_v2/" --silent | jq -r '.sonarfile_set[]' | grep -m 1 -E "$year-$month-[0-3]{1}[0-9]{1}-[0-9]{10}-fdns_cname.json.gz")
c_link=$(curl -H "X-Api-Key: $api" "https://us.api.insight.rapid7.com/opendata/studies/sonar.fdns_v2/$cname/download/" --silent | jq '.url' | sed 's/\"//g')
wget -bqc "$c_link" -O ~/recon/data/fdns_cname.json.gz

file=$(curl -H "X-Api-Key: $api" "https://us.api.insight.rapid7.com/opendata/studies/sonar.rdns_v2/" --silent | jq -r '.sonarfile_set[0]')
download=$(curl -H "X-Api-Key: $api" "https://us.api.insight.rapid7.com/opendata/studies/sonar.rdns_v2/$file/download/" --silent | jq '.url' | sed 's/\"//g')
wget -bqc "$download" -O ~/recon/data/reverse_dns.json.gz
