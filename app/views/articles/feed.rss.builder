xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0' do
  xml.channel do
    xml.title 'App Dev Academy'
    xml.description 'App Dev Academy is building native iOS, macOS and Android apps + websites with Ruby on Rails and React.'
    xml.link articles_url
    
    for article in @articles
      xml.item do
        xml.title article.title
        xml.description article.html_preview
        xml.pubDate article.published_at.to_s(:rfc822)
        xml.link article_url(article)
        xml.guid article_url(article)
      end
    end
  end
end