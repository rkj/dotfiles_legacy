
require 'rubygems'
require 'ap'
require 'zlib'
require 'nokogiri'
require 'open-uri'

def read_uri(url)
  data = open(url)
  data = Zlib::GzipReader.new(data) if data.content_encoding.include? 'gzip'
  Nokogiri::HTML(data)
end

url = 'http://www.cinema-city.pl/index.php?module=movie&action=repertoire&cid=1081'
list = read_uri(url)
titles = list.search("a").select { |a| a['href'] =~ /module=movie&id=/ }.map { |a| {:pl => a.content, :en => a.ancestors("td").at("h4").content} }
movies = titles.map do |h|
  search = read_uri URI.encode("http://www.imdb.com/find?s=tt&q=#{h[:en]}")
  page = read_uri(File.join("http://www.imdb.com/", search.search("div#main a").first["href"])) rescue search
  info = page.search("#tn15content .info")
  infos = Hash[*info.map do |i| 
    [ 
      (i.at("h5").content.gsub(/:\s*$/, '').downcase.intern rescue nil), 
      (i.at(".info-content").content.gsub(/\s+/, ' ').strip.sub(/\s*See more.*$/, '').gsub(/\s*\|\s*/, ', ') rescue nil) 
    ].compact
  end.reject { |x| x.length < 2 }.flatten]
  infos[:genre] = page.search("#tn15content .info").find { |d| d.content =~ /\s*Genre/ }.search("a")[0..-2].map(&:content).join(", ")
  infos[:rating] = page.at(".starbar-meta").content.to_f
  infos[:title] = page.at("meta[@name='title']")["content"]
  infos.merge(h)
end

def pu(h, k)
  puts "#{k}: #{h[k]}"
end

movies.sort_by { |h| -h[:rating] }.each do |m|
  puts "#{m[:pl]} (#{m[:en]}) [#{m[:title]}]"
  puts m[:rating].to_s + " " + "*" * m[:rating].to_i
  pu m, :genre
  pu m, :tagline
  pu m, :plot
  pu m, :director
  puts "-" * 40
end
