#!/usr/bin/env ruby
# coding: utf-8
require "csv"
require "time"
require "csv2md"
require "kramdown"

def series_of(version)
  m = version.match(/\Av?(\d+\.\d+)/)
  m[1]
end

bvs = File.readlines("bvs.txt").map(&:chomp)
gvs = File.readlines("gvs.txt").map(&:chomp)
gss = gvs.map{ series_of(_1) }.uniq

bi0 = bvs.index("v2.13.0")
bi1 = bvs.index("v2.11.4")
bi2 = bvs.index("v2.11.0")

gs1 = %w[2.10 2.9 2.8 2.7 2.6 2.5 2.4 2.3 2.2]
gs2 = %w[2.1 2.0 11.11 11.10]

compatible = "✅"
incompatible = "❌"

matrix = []
row0 = ["", "GitHub Enterprise Server"].concat(Array.new(gss.size - 1))
matrix << row0
row1 = ["backup-utils"].concat(gss)
matrix << row1

# https://github.com/github/backup-utils/blob/master/docs/requirements.md#github-enterprise-server-version-requirements
# bv 2.13.0 -> gv [2.13, 2.12, 2.11], ...
# bv 2.11.4 -> gv [2.10, ..., 2.2]
# bv 2.11.0 -> gv [2.1, ...]
0.upto(bvs.length-1) do |i|
  bv = bvs[i]
  if i <= bi0
    bs = series_of(bv)
    gi0 = gss.index(bs)
    gi1 = gi0 + 1
    gi2 = gi0 + 2
    gs = [gss[gi0], gss[gi1], gss[gi2]]
    row = gss.map { gs.include?(_1) ? compatible : incompatible }
    row.insert(0, bv)
    matrix << row
  elsif bi1 <= i && i <= bi2
    row = gss.map { gs1.include?(_1) ? compatible : incompatible }
    row.insert(0, bv)
    matrix << row
  else
    row = gss.map { gs2.include?(_1) ? compatible : incompatible }
    row.insert(0, bv)
    matrix << row
  end
end

# create CSV
CSV.open("matrix.csv", "w") do |csv|
  matrix.each do |row|
    csv << row
  end
end

# generate HTML table
matrix.slice!(0, 1)
csv = CSV.generate do |csv|
  # add dummy header to be replaced
  csv << Array.new(matrix[0].size)
  matrix.each do |row|
    csv << row
  end
end
markdown = Csv2md.new(csv).gfm
html = Kramdown::Document.new(markdown).to_html
thead = <<HTML
  <thead>
    <tr>
      <th> </th>
      <th colspan="#{gss.size}">GitHub Enterprise Server</th>
    </tr>
  </thead>
HTML
html.sub!(%r!  <thead>\s*<tr>\s*.*</tr>\s*</thead>!m, thead)

# update README
readme = <<README
# caniuse-backup-utils

Version matrix of [GitHub Enterprise Server](https://docs.github.com/en/enterprise-server@3.6/admin/all-releases) and [backup-utils](https://github.com/github/backup-utils).

[GitHub Enterprise Server version requirements](https://github.com/github/backup-utils/blob/master/docs/requirements.md#github-enterprise-server-version-requirements)

[Can I use backup-utils? - Google Sheets](https://docs.google.com/spreadsheets/d/1L78xOOjCm-j3r3cRj-gLFwosfoqw1d6-hmz2MPZmUsA/edit#gid=0)

#{html}
README

File.write('README.md', readme)
