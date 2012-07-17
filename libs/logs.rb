
module Logs
  @@size = 100
  def self.filename
    File.expand_path '../bokete.log', File.dirname(__FILE__)
  end

  def self.all
    return [] unless File.exists? filename
    open(filename, 'r') do |f|
      return f.read.split(/[\r\n]/)
    end
  end

  def self.include?(log)
    all.include? log
  end

  def self.add(log)
    logs = all
    logs.push log
    while logs.size > limit
      logs.shift
    end
    open(filename, 'w+') do |f|
      f.write logs.join("\n")
    end
    logs
  end

  def self.push(log)
    add log
  end

  def self.limit=(size=100)
    @@size = size
  end

  def self.limit
    @@size
  end
end

if __FILE__ == $0
  Logs.limit = 5
  puts Logs.filename
  p Logs.all
  p Logs.include? '123'
  p Logs.include? 'nothing'
  Logs.add rand 1000
end
