require 'active_support'
require "open-uri"
require "rubygems"
require "nokogiri"
require 'nkf'
require 'pp'



#検索結果ではURL単一しか取れないから
#Aowsomeなどを利用して単一の検索結果に対して
#複数のURLを取得しそのURLの画像とタイトルを取得する。

class Tasks::InsertContentsTask
  # To change this template use File | Settings | File Templates.
  def self.execute_mery
    #TODO:主要サイトの洗い出しとそれに合わせての検索結果をどうするかを決める。
    #TODO:テーブルにどこまでデータを保持するかを検討する必要がある。。


    #ヘアーアレンジなどの可愛め系(mery)
    #url = ['http://mery.jp/hairstyle','http://mery.jp/love','http://mery.jp/gourmet']
    #時短系(nanapi,peachy)
    #url = ['http://nanapi.jp/search/q:%E6%99%82%E7%9F%AD/rank:1/theme_id:626','http://news.livedoor.com/search/article/?ie=euc-jp&word=%BB%FE%C3%BB%A1%A1%C0%E1%CC%F3']
    #可愛い系(style 4 designe)
    #url = ['http://design.style4.info/?s=%E3%82%AB%E3%83%AF%E3%82%A4%E3%82%A4&submit=Search','http://design.style4.info/?s=%E7%B5%B6%E6%99%AF&submit=Search']

    url = 'http://mery.jp/hairstyle'

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
        content= Content.new
        p thumb.xpath('img').attribute('src').value
        p thumb.xpath('@href').text
        content.image_url =  thumb.xpath('img').attribute('src').value
        content.url = 'http://mery.jp' + thumb.xpath('@href').to_s
        content.genre = 1
        content.save

      end

    end
  end

  def self.execute_style4
    #TODO:主要サイトの洗い出しとそれに合わせての検索結果をどうするかを決める。
    #TODO:テーブルにどこまでデータを保持するかを検討する必要がある。。
    #TODO:ある程度のサイトは一つのモジュールで対応可能なためパラメータや条件で取得を変えるようにしたい。


    #ヘアーアレンジなどの可愛め系(mery)
    #url = ['http://mery.jp/hairstyle','http://mery.jp/love','http://mery.jp/gourmet']
    #時短系(nanapi,peachy)
    #nanapiは画像が汚いので取り扱わない
    #url = ['http://nanapi.jp/search/q:%E6%99%82%E7%9F%AD/rank:1/theme_id:613','http://news.livedoor.com/search/article/?ie=euc-jp&word=%BB%FE%C3%BB%A1%A1%C0%E1%CC%F3']
    #可愛い系(style 4 designe)
    #url = ['http://design.style4.info/?s=%E3%82%AB%E3%83%AF%E3%82%A4%E3%82%A4&submit=Search','http://design.style4.info/?s=%E7%B5%B6%E6%99%AF&submit=Search']

    #url = 'http://nanapi.jp/search/q:%E6%99%82%E7%9F%AD/rank:1/theme_id:613'
    url = 'http://design.style4.info/?s=%E3%82%AB%E3%83%AF%E3%82%A4%E3%82%A4&submit=Search'

    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end
    doc = Nokogiri::HTML.parse(html, nil, charset)
    p doc.title
    doc.xpath('//div[@class="masonry"]').each do |node|
      #image_url
      #thumbs
      thumbs = node.xpath('//div[@class="index-content-img"]/a')
      thumbs.each do |thumb|
        content= Content.new
        p thumb.xpath('img').attribute('src').value
        p thumb.xpath('@href').text
        content.image_url =  thumb.xpath('img').attribute('src').value
        content.url = thumb.xpath('@href').to_s
        content.genre = 2
        content.save

      end

    end

  end

  def self.execute_api
    #TODO:主要サイトの洗い出しとそれに合わせての検索結果をどうするかを決める。
    #TODO:テーブルにどこまでデータを保持するかを検討する必要がある。。
    #TODO:ある程度のサイトは一つのモジュールで対応可能なためパラメータや条件で取得を変えるようにしたい。


    #ヘアーアレンジなどの可愛め系(mery)
    #url = ['http://mery.jp/hairstyle','http://mery.jp/love','http://mery.jp/gourmet']
    #時短系(nanapi,peachy)
    #nanapiは画像が汚いので取り扱わない
    #url = ['http://nanapi.jp/search/q:%E6%99%82%E7%9F%AD/rank:1/theme_id:613','http://news.livedoor.com/search/article/?ie=euc-jp&word=%BB%FE%C3%BB%A1%A1%C0%E1%CC%F3']
    #可愛い系(style 4 designe)
    #url = ['http://design.style4.info/?s=%E3%82%AB%E3%83%AF%E3%82%A4%E3%82%A4&submit=Search','http://design.style4.info/?s=%E7%B5%B6%E6%99%AF&submit=Search']

    #url = 'http://nanapi.jp/search/q:%E6%99%82%E7%9F%AD/rank:1/theme_id:613'
    #url = 'http://webservice.recruit.co.jp/beauty/salon/v1?order=3&name=%E3%82%B5%E3%83%AD%E3%83%B3&key=d80cc5011c92e61d'

    h = Hash.from_xml(open('http://webservice.recruit.co.jp/beauty/salon/v1?order=3&name=%E3%82%B5%E3%83%AD%E3%83%B3&key=d80cc5011c92e61d').read)
    pp h['results']['salon'].first['id']

  end
end


