#!/usr/bin/env ruby
# encoding: utf-8

require 'uri'
require 'tempfile'

def find_url(path)
  hgrc = File.join(path, ".hg", "hgrc")
  if File.exists? hgrc
    File.read(hgrc).match(/default\s*=\s*(.*)/)[1] rescue path
  else
    path
  end
end

def extract_subrepos(sub, repo)
  sub.each_line.map(&:strip).reject(&:empty?).map do |line|
    path, uri = *line.split(/\s*=\s*/).map { |u| URI.parse u.sub(/^\s*\[\w+\]\s*/, '') }
    uri = find_url File.join(repo, path) unless uri.absolute?
    [path, uri].map(&:to_s)
  end
end

@@repos = {}
Dir["**/.hg"].each do |repo|
  repo = File.dirname repo 
  url = find_url(repo)
  next if @@repos.has_key? url
  subpath = File.join(repo, '.hgsub')
  @@repos[url] = if File.exists? subpath
                   extract_subrepos File.read(subpath), repo
                 else
                   []
                 end
end

io = Tempfile.new("subrepos_dot")
io.puts "digraph subrepos {"
io.puts "graph [splines=ortho, ranksep=2];"
io.puts "rankdir=LR;"
@@repos.sort.each do |repo, subrepos|
  io.puts %{"%s" [height=0.75, shape=box]} % repo
  subrepos.sort.each do |sub|
    io.puts %{"%s" -> "%s" [label="%s", decorate=false]} % [repo, sub[1], sub[0]]
  end
end
io.puts "}"
io.close

#system "cat #{io.path}"
res = "subrepos.png"
system %{dot #{io.path} -Tpng >"#{res}"}
system "rm #{io.path}"
system "open #{res}"

