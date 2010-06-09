#!/usr/bin/env ruby

require 'date'
require 'time'
require 'strscan'

UNITS = { "h" => 3600, "m" => 60, "s" => 1}
def time_to_str(seconds)
  return "0" if seconds == 0
  str = seconds >= 0 ? "+" : "-"
  seconds = seconds.abs
  UNITS.to_a.sort_by { |e| e[1] }.reverse.each do |name, amount|
    c = (seconds / amount).floor
    next unless c > 0
    str << "#{c}#{name}" 
    seconds -= c * amount 
  end
  str
end

def parse_time(str)
  s = StringScanner.new(str)
  sign = s.scan /(\+|-)/
  time = 0
  until s.eos?
    s.scan /(\d+)(\.\d+)?([hms])/
    time += "#{s[1]}#{s[2]}".to_f * UNITS[s[3]]
  end
  time *= -1 if sign == "-"
  time
rescue
  nil
end

# %w(+1h -2h +1.5h -0.5h +1h30m -30m).each do |t|
#   x = parse_time(t) || raise
#   p x
# end

path = ENV['WORKLOG_PATH'] || "#{ENV["HOME"]}/.work_log.txt"
%x{touch #{path}}
if ARGV.size > 0 && ARGV[0] =~ /(\+?|-)\d+/
  t = parse_time(ARGV[0]) 
  raise Exception, "Unable to parse #{ARGV[0]}" if t.nil?
  File.open(path, "a+") { |f| f.puts "#{Date.today.to_s} #{time_to_str(t)} #{ARGV[1..-1].join(" ")}"}
end
verbose = ARGV.size > 0 && ARGV.include?("-v")
sum = 0
disp = []
IO.foreach(path) do |line|
  date, time, comment = line.split(/\s/, 3)
  t = parse_time(time)
  sum += t
  disp << [time_to_str(sum), time_to_str(t), date, comment.strip] if verbose
end
if verbose
  cw = disp.map { |t| t[0, 3].map { |v| v.length} }.flatten.max + 1
  lw = disp.map { |d| d[3].length }.max + 1
  disp.each do |line|
    line[1, 2].each { |c| print c; print " " * (cw - c.length)}
    print line[3]
    print " " * (lw - line[3].length)
    puts line[0]
  end
else
  puts time_to_str(sum)
end
