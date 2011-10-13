#!/usr/bin/env ruby

# No rubygems for faster loading
# require 'rubygems'
require 'optparse'
require 'strscan'
require 'date'

TIME_UNITS = { "h" => 3600, "m" => 60, "s" => 1}
class Duration
  def initialize(seconds = 0)
    @seconds = seconds
  end
  
  def +(other)
    @seconds += other.to_i
    self
  end
  
  def -(other)
    @seconds -= other.to_i
    self
  end
  
  def to_i
    @seconds
  end
  
  def to_s
    return "0" if @seconds == 0
    TIME_UNITS.to_a.sort_by { |e| -e[1] }.inject([@seconds >= 0 ? "+" : "-", @seconds.abs]) do |sum, cur|
      str, seconds = *sum
      name, amount = *cur
      c = (seconds / amount).floor
      sum unless c > 0
      ["#{str}#{c}#{name}", seconds - c * amount]
    end.first.sub(/0s$/, "")
  end
end

class String
  def to_duration()
    s = StringScanner.new(self)
    sign = s.scan /(\+|-)/
    time = 0
    until s.eos?
      s.scan /(\d+)(\.\d+)?([hms])/
      time += "#{s[1]}#{s[2]}".to_f * TIME_UNITS[s[3]]
    end
    time *= -1 if sign == "-"
    Duration.new time
  rescue
    nil
  end
end

@opts = {:path => ENV['WORKLOG_PATH'] || "#{ENV["HOME"]}/.work_log.txt", :date => Date.today}
OptionParser.new do |opts|
  opts.banner = "Usage: timelog.rb [options]"

  opts.on("-p", "--path PATH", String, "Path to data file") { |p| @opts[:path] = p }
  opts.on("-r", "--rate RATE", Integer, "Rate per hour") { |r| @opts[:rate] = r }
  opts.on("-d", "--date DATE", String, "Date to log time in %Y-%m-%d format") { |d| @opts[:date] = Date.parse(d, "%Y-%m-%d") }
  opts.on("-e", "--edit") { `$EDITOR #{@opts[:path]}`; exit(0) }
  opts.on("-v", "--[no-]verbose", "Run verbosely") { |v| @opts[:verbose] = v }
end.parse!

if ARGV.size > 0 && ARGV[0] =~ /^(\+?|-)\d+/
  t = ARGV[0].to_duration
  raise Exception, "Unable to parse #{ARGV[0]}" if t.nil?
  File.open(@opts[:path], "a+") { |f| f.puts "#{@opts[:date].to_s} #{t.to_s} #{ARGV[1..-1].join(" ")}"}
end

sum = Duration.new
disp = []
payments = []
IO.foreach(@opts[:path]) do |line|
  if line =~ /^-/
    payments << line.split(/\s/, 2)
    next
  end
  date, time, comment = line.split(/\s/, 3)
  t = time.to_duration
  sum += t
  disp << [sum.to_s, t.to_s, date, comment.strip]
end
if @opts[:verbose]
  cw = disp.map { |t| t[0, 3].map { |v| v.length} }.flatten.max + 1 rescue 1
  lw = disp.map { |d| d[3].length }.max + 1 rescue 1
  disp.each do |line|
    line[1, 2].each { |c| print c; print " " * (cw - c.length)}
    print line[3]
    print " " * (lw - line[3].length)
    puts line[0]
  end
else
  puts sum
end
if @opts[:rate]
  puts sum.to_i * @opts[:rate] / TIME_UNITS["h"]
end
