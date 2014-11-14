require 'open-uri'
require 'nokogiri'

class Crawler

  def initialize
    @visited = {}
    @count = 0
    @max = 100
  end

  def crawl(url)
    slow_crawl(url)
  end

  def slow_crawl(url)
    return unless @count < @max
    record(url) 
    @count += 1
    puts "visited #{@count} sites"
    doc = Nokogiri::HTML(open(url))
    links = doc.css("a")
    hrefs = links.map { |link| link.attribute('href').to_s}.uniq.sort.delete_if { |href| href.empty? || !href.match(/http/) }
    hrefs.each do |link|
      slow_crawl(url) 
    end
    puts "done"
  end

  private

  def record(url)
    url= url + "*"
    current = @visited
    url.chars.each do |char|
      if current[char] == "*"
        break
      elsif current[char]
        current = current[char]
      else
        current[char] = char == "*" ? "*" : {}
        current = current[char]
      end
    end
  end

end

c = Crawler.new
start = Time.now
c.crawl("http://www.theguardian.com")
end_time = Time.now
puts "Took #{end_time-start}"


