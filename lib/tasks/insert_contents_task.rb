require 'active_support'
require "open-uri"
require "rubygems"
require "nokogiri"
require 'nkf'
require 'pp'

# -*- encoding: utf-8 -*-


#検索結果ではURL単一しか取れないから
#Aowsomeなどを利用して単一の検索結果に対して
#複数のURLを取得しそのURLの画像とタイトルを取得する。

class Tasks::InsertContentsTask
  # To change this template use File | Settings | File Templates.
  def self.execute_mery
    #TODO:主要サイトの洗い出しとそれに合わせての検索結果をどうするかを決める。
    #TODO:テーブルにどこまでデータを保持するかを検討する必要がある。。

    urls = ['http://mery.jp/search?q=%E3%82%B3%E3%82%B9%E3%83%A1',
            'http://mery.jp/search?page=2&q=%E3%82%B3%E3%82%B9%E3%83%A1',
            'http://mery.jp/hairstyle',
            'http://mery.jp/beauty',
            'http://mery.jp/search?q=%E3%83%91%E3%83%B3%E3%82%B1%E3%83%BC%E3%82%AD',
            'http://mery.jp/search?q=%E3%82%AF%E3%83%AA%E3%82%B9%E3%83%9E%E3%82%B9',
            'http://mery.jp/search?q=%E3%83%86%E3%82%A3%E3%83%95%E3%82%A1%E3%83%8B%E3%83%BC',
            'http://mery.jp/search?q=%E7%BE%8E%E5%AE%B9',
            'http://mery.jp/search?q=%E3%83%A1%E3%82%A4%E3%82%AF'
    ]
    urls.each do |url|

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
        Content.destroy_all()

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

  end

  def self.execute_style4
    #TODO:主要サイトの洗い出しとそれに合わせての検索結果をどうするかを決める。
    #TODO:テーブルにどこまでデータを保持するかを検討する必要がある。。
    #TODO:ある程度のサイトは一つのモジュールで対応可能なためパラメータや条件で取得を変えるようにしたい。


    urls = ['http://design.style4.info/page/2/?s=%E3%82%AB%E3%83%AF%E3%82%A4%E3%82%A4&submit=Search',
            'http://design.style4.info/page/3/?s=%E3%82%AB%E3%83%AF%E3%82%A4%E3%82%A4&submit=Search',
            'http://design.style4.info/category/video/page/6/',
            'http://design.style4.info/category/video/page/2/',
            'http://design.style4.info/category/interior/page/3/']
    urls.each do |url|
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
          content.genre = 3
          content.save

        end

      end

    end


  end

  def self.execute_api
    #TODO:主要サイトの洗い出しとそれに合わせての検索結果をどうするかを決める。
    #TODO:テーブルにどこまでデータを保持するかを検討する必要がある。。
    #TODO:ある程度のサイトは一つのモジュールで対応可能なためパラメータや条件で取得を変えるようにしたい。

    apis = ['http://webservice.recruit.co.jp/relax/salon/v1?response_reserve=1&count=15&order=3&address=%E9%8A%80%E5%BA%A7&key=d80cc5011c92e61d',
            'http://webservice.recruit.co.jp/relax/salon/v1?response_reserve=1&count=15&order=3&address=%E6%B8%8B%E8%B0%B7&key=d80cc5011c92e61d'
    ]
    apis.each do |url|
      h = Hash.from_xml(open(url).read)

      h['results']['salon'].each do |t|
        pp t['urls']['pc']
        pp t['mood'][0]['photo']
        content= Content.new
        content.image_url =  t['mood'][0]['photo']
        content.url = t['urls']['pc']
        content.genre = 4
        content.save

      end
    end

  end
end


