lib = File.expand_path('lib', File.dirname(__FILE__))
$:.unshift lib unless $:.include?(lib)

require 'rubygems'
require 'rake'
require 'rake/rdoctask'
require 'rake/testtask'
require 'slowweb'

#############################################################################
#
# Standard tasks
#
#############################################################################

task :console do
  sh "irb -rubygems -r ./lib/slowweb.rb"
end


#############################################################################
#
# Packaging tasks
#
#############################################################################

task :release do
  puts ""
  print "Are you sure you want to relase SlowWeb #{SlowWeb::VERSION}? [y/N] "
  exit unless STDIN.gets.index(/y/i) == 0
  
  unless `git branch` =~ /^\* master$/
    puts "You must be on the master branch to release!"
    exit!
  end
  
  # Build gem and upload
  sh "gem build slowweb.gemspec"
  sh "gem push slowweb-#{SlowWeb::VERSION}.gem"
  sh "rm slowweb-#{SlowWeb::VERSION}.gem"
  
  # Commit
  sh "git commit --allow-empty -a -m 'v#{SlowWeb::VERSION}'"
  sh "git tag v#{SlowWeb::VERSION}"
  sh "git push origin master"
  sh "git push origin v#{SlowWeb::VERSION}"
end
