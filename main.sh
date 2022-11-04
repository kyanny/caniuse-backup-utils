#!/bin/bash
set -x

# Fetch all backup-utils release versions
gh api --paginate /repos/github/backup-utils/releases -q '.[].tag_name' | sort -rV > bvs.txt

# Fetch all GitHub Enterprise Server release versions
curl -s https://raw.githubusercontent.com/kyanny/github-enterprise-releases.json/main/releases.json | jq -r '.[].title' | sort -V | perl -nle 'BEGIN{ $, = "\n"; @not_eleven = () };
/^11\./ ? print : push @not_eleven, $_;
END{ print @not_eleven }' | tac > gvs.txt

# Update matrix and README
bundle exec ruby main.rb

# Update Google Sheet
curl -s https://script.google.com/macros/s/AKfycbweKZloTv9KOprf7QoHOKOv9el2LZqTjNXmB_fUZupqoCIsmHc4s1diB3yk5aiW8YfA/exec
