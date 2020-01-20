#!/usr/bin/env ruby

require 'fileutils'

SRC = File.expand_path ARGV[0]
DEST = File.expand_path ARGV[1]

Dir.chdir SRC
entries = Dir['**/*']
entries.each do |f|
  s = File.join(SRC, f)
  next if File.directory? s
  d = File.join(DEST, f)
  FileUtils.mkdir_p(File.dirname(d))
  FileUtils.cp s,d
  puts "#{s}\n  => #{d}"
end

