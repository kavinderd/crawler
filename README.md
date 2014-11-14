# Intro

Crawler is a web crawler that for any given url keeps crawling until it can no longer find any further links.

This is definitely not the library you're looking for.

# Usage

require 'crawler'

c = Crawler.new
c.crawl("www.theguardian.com")

#=> Starting crawl of www.theguardian.com
#=> Sites crawled: 1000000
