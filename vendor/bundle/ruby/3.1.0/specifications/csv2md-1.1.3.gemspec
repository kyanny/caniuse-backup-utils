# -*- encoding: utf-8 -*-
# stub: csv2md 1.1.3 ruby lib

Gem::Specification.new do |s|
  s.name = "csv2md".freeze
  s.version = "1.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jonathan Hoyt".freeze]
  s.date = "2015-04-29"
  s.description = "Convert csv into a GitHub Flavored Markdown table".freeze
  s.email = "jonmagic@gmail.com".freeze
  s.executables = ["csv2md".freeze]
  s.files = ["bin/csv2md".freeze]
  s.homepage = "https://github.com/jonmagic/csv2md".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.7".freeze
  s.summary = "Convert csv into a GitHub Flavored Markdown table".freeze

  s.installed_by_version = "3.3.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.4"])
    s.add_development_dependency(%q<minitest>.freeze, ["~> 5.6"])
  else
    s.add_dependency(%q<rake>.freeze, ["~> 10.4"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.6"])
  end
end
