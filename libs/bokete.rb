#!/usr/bin/env ruby
require 'rubygems'
require 'nokogiri'
require 'net/http'
require 'uri'


module Bokete
  class Error < Exception
  end
  
  def self.recent
    get_links 'http://bokete.jp/boke/recent'
  end

  def self.hot
    get_links 'http://bokete.jp/boke/hot'
  end

  def self.popular
    get_links 'http://bokete.jp/boke/popular'
  end

  private
  def self.get_links(url)
    uri = URI.parse url
    res = Net::HTTP.start(uri.host, uri.port).request(Net::HTTP::Get.new uri.request_uri)
    raise Error, "status code #{res.code}" unless res.code.to_i == 200
    doc = Nokogiri::HTML res.body
    doc.xpath('//a').map{|a|
      a['href']
    }.reject{|a|
      a !~ /\/boke\/\d+$/
    }.map{|a|
      "http://bokete.jp#{a}"
    }.uniq
  end
end


if __FILE__ == $0
  puts 'recent--'
  p Bokete.recent
  puts 'hot--'
  p Bokete.hot
  puts 'popular--'
  p Bokete.popular
end
