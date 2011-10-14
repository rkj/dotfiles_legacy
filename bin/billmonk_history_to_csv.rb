#!/usr/bin/env ruby
# encoding: UTF-8

if ARGV.length < 1
  puts "Usage: #{$0} filename"
  exit 1
end

require 'rubygems'
require 'nokogiri'
require 'date'
require RUBY_VERSION >= "1.9" ? 'csv' : 'fastercsv' 
require 'ap'

if RUBY_VERSION < "1.9"
  class Float
    def round(pos = 0)
      x = self * (10 ** pos) + 0.5
      x.to_i.to_f / (10 ** pos)
    end
  end
end

file = ARGV[0]
html = Nokogiri::HTML(open(file))
table = html.search("table.standard_orange")
total = 0
table.search("tr").reverse.each do |tr|
  tds = tr.search("td").map { |t| t.content.strip }
  date = Date.parse(tds[0]) rescue next
  credit, debit = tds[3, 2].map { |x| x.match(/(\d+\.\d+).*zł/)[1].to_f rescue 0 }
  total = total + credit - debit
  puts [date.to_s, tds[2], credit, debit, total.round(2)].to_csv
end

