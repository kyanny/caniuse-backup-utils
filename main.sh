#!/bin/bash
set -x

gh api --paginate /repos/github/backup-utils/releases -q '.[].tag_name' | sort -rV > bvs.txt
curl -s https://raw.githubusercontent.com/kyanny/github-enterprise-releases.json/main/releases.json | jq -r '.[].title' | sort -V | perl -nle 'BEGIN{ $, = "\n"; @not_eleven = () };
/^11\./ ? print : push @not_eleven, $_;
END{ print @not_eleven }' | tac > gvs.txt
bundle exec ruby main.rb
