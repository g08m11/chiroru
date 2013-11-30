
datas = [
  {
    id:  2,
    image_url: 'http://dju9dx81hnvkz.cloudfront.net/12635/main.php/normal?1385440234',
    url: 'http://mery.jp/6897' ,
    title: '1人1枚は当然！ニット素材のタイトスカートを要チェック♡',
    created_at: DateTime.now,
    updated_at: DateTime.now

  },
{
  id:  3,
  image_url: 'http://d20u4i5j3l9sia.cloudfront.net/67177/201308221144251da.jpg/normal?1385543259',
  url: 'http://mery.jp/6990' ,
  title: 'つい頼りたくなる！飲むだけ楽ちんなダイエットサプリが気になる・・・！',
  created_at: DateTime.now,
  updated_at: DateTime.now

}

]
datas.each do |data| {
  Content.create(data)

}
end
