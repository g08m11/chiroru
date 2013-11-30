require 'nokogiri'
require 'open-uri'

#検索結果ではURL単一しか取れないから
#Aowsomeなどを利用して単一の検索結果に対して
#複数のURLを取得しそのURLの画像とタイトルを取得する。

class Tasks::InsertContentsTask
  # To change this template use File | Settings | File Templates.
  def self.execute
    date = DateTime.now
    puts "scraping...  >> " + date.to_s
    hotEntryUrl = "http://mery.jp/hairstyle"
    hotEntryHtml = Nokogiri::HTML(open(hotEntryUrl), nil, 'UTF-8')

    hotEntryHtml.search('//li[@class="article_list_content clearfix"]').each do |doc|

      content = Content.new
      content.title 	= doc.search('h3/a/@title').text
      content.save
    end
  end
end

