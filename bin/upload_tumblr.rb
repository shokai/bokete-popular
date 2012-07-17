#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require File.expand_path 'bootstrap', File.dirname(__FILE__)+'/../'
require 'tumblr'

if ARGV.empty?
  STDERR.puts 'image required.'
  STDERR.puts "e.g.  ruby #{$0} image.jpg"
  exit 1
end

file = ARGV.first

puts "#{file} uploading.."
res = Tumblr.new(Conf['tumblr']['mail'], Conf['tumblr']['pass']).
  write_photo(file, Conf['tumblr']['description'])

if res.to_i > 0
  puts "success!! => #{res}"
else
  puts "failed."
end
