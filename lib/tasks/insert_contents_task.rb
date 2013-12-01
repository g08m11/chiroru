require "open-uri"
require "rubygems"
require "nokogiri"


#検索結果ではURL単一しか取れないから
#Aowsomeなどを利用して単一の検索結果に対して
#複数のURLを取得しそのURLの画像とタイトルを取得する。

class Tasks::InsertContentsTask
  # To change this template use File | Settings | File Templates.
  def self.execute
    url = ARGV[0]
    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end
    doc = Nokogiri::HTML.parse(html, nil, charset)
    p doc.title
    doc.xpath('//div[@class="article_list"]').each do |node|

      #image_url
      #thumbs
      thumbs = node.xpath('//div[@class="article_list_thumb"]/a')
      thumbs.each do |thumb|
        p thumb.xpath('img').attribute('src').value
        p thumb.xpath('@href').text
      end

    end
  end
end

