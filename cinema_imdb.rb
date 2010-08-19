
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
titles.map do |h|
  search = read_uri URI.encode("http://www.imdb.com/find?s=tt&q=#{h[:en]}")
  page = read_uri(File.join("http://www.imdb.com/", search.search("div#main a").first["href"])) rescue search
  title = page.at("meta[@name='title']")["content"]
  info = page.search("#tn15content .info")
  infos = Hash[*info.map { |i| [ (i.at("h5").content.gsub(/:\s*$/, '') rescue nil), (i.at(".info-content").content.gsub(/\s+/, ' ').strip rescue nil) ].compact }.reject { |x| x.length < 2 }.flatten]
  ap infos
  rating = page.at(".starbar-meta").content.to_f
  # h[:genre] = genre
  h[:rating] = rating
  h[:imdb_title] = title
  ap h
  h
end
