#!/usr/bin/env ruby
require 'tmpdir'
require 'base64'
require 'headless'

module Capture
  def self.make(url, fname=nil)
    fname = Base64.encode64(url).strip + '.png' unless fname
    if block_given?
      yield "#{url} => #{fname}"
    end
    
    Dir.mktmpdir do |dir|
      tmp = "#{dir}/TMP.png"
      Headless.ly do
        cmd = "capturejs -u '#{url}' -o '#{tmp}' --selector 'div.boke-entry'"
        if block_given?
          yield cmd
        end
        system cmd
      end
      cmd = "convert -trim -bordercolor '#FFFFFF' -border '5%x5%' '#{tmp}' '#{fname}'"
      if block_given?
        yield cmd
      end
      system cmd
    end
    fname
  end
end

if __FILE__ == $0
  if ARGV.size < 1
    puts "ruby #{$0} http://bokete.jp/boke/12345 boke.png"
    exit 1
  end
  
  url = ARGV.shift
  fname = ARGV.shift
  Capture.make url, fname
end
