# -*- encoding: utf-8 -*-
# stub: jekyll-commonmark 1.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "jekyll-commonmark"
  s.version = "1.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Pat Hawks"]
  s.date = "2019-03-25"
  s.email = "pat@pathawks.com"
  s.homepage = "https://github.com/pathawks/jekyll-commonmark"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0")
  s.rubygems_version = "2.5.2.1"
  s.summary = "CommonMark generator for Jekyll"

  s.installed_by_version = "2.5.2.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<commonmarker>, ["~> 0.14"])
      s.add_runtime_dependency(%q<jekyll>, ["< 5.0", ">= 3.7"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<rake>, ["~> 12.0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.0"])
      s.add_development_dependency(%q<rubocop-jekyll>, ["~> 0.5"])
    else
      s.add_dependency(%q<commonmarker>, ["~> 0.14"])
      s.add_dependency(%q<jekyll>, ["< 5.0", ">= 3.7"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<rake>, ["~> 12.0"])
      s.add_dependency(%q<rspec>, ["~> 3.0"])
      s.add_dependency(%q<rubocop-jekyll>, ["~> 0.5"])
    end
  else
    s.add_dependency(%q<commonmarker>, ["~> 0.14"])
    s.add_dependency(%q<jekyll>, ["< 5.0", ">= 3.7"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<rake>, ["~> 12.0"])
    s.add_dependency(%q<rspec>, ["~> 3.0"])
    s.add_dependency(%q<rubocop-jekyll>, ["~> 0.5"])
  end
end
