#!/usr/bin/env ruby
require File.expand_path 'bootstrap', File.dirname(__FILE__)
require 'capture'
require 'logs'
require 'feed-normalizer'
require 'open-uri'

out = ARGV.shift

feed_url = 'http://bokete.jp/boke/popular/rss'

feed = FeedNormalizer::FeedNormalizer.parse open(feed_url)
urls = feed.entries.map{|i| i.url}

url = (urls - Logs.all).sample
out = Capture.make url, out do |log|
  puts log
end
exit 1 unless File.exists? out
Logs.add url
