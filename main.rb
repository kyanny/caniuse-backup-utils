#!/usr/bin/env ruby

require 'roo'
require 'csv2md'
xlsx = Roo::Excelx.new('CanIusebackup-utils.xlsx')
sheet = xlsx.sheet(0)
csv = sheet.to_csv
csv2md = Csv2md.new(csv)
md_table = csv2md.gfm

readme = <<README
# caniuse-backup-utils

Version matrix of [GitHub Enterprise Server](https://docs.github.com/en/enterprise-server@3.6/admin/all-releases) and [backup-utils](https://github.com/github/backup-utils).

[GitHub Enterprise Server version requirements](https://github.com/github/backup-utils/blob/master/docs/requirements.md#github-enterprise-server-version-requirements)

[Can I use backup-utils? - Google Sheets](https://docs.google.com/spreadsheets/d/1L78xOOjCm-j3r3cRj-gLFwosfoqw1d6-hmz2MPZmUsA/edit#gid=0)

#{md_table}

README

File.write('README.md', readme)
