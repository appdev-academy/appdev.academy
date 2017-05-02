# StaticPages
pages = [
  { slug: 'about', content: '## About Page', html_content: '<h2>About Page</h2>' },
  { slug: 'contacts', content: '## Contacts Page', html_content: '<h2>Contacts Page</h2>' },
  { slug: 'home', content: '## Home Page', html_content: '<h2>Home Page</h2>' },
  { slug: 'guides', content: '## Guides Page', html_content: '<h2>Guides Page</h2>' },
  { slug: 'open-source', content: '## Open Source Page', html_content: '<h2>Open Source Page</h2>' },
  { slug: 'portfolio', content: '## Portfolio Page', html_content: '<h2>Portfolio Page</h2>' },
  { slug: 'screencasts', content: '## Screencasts Page', html_content: '<h2>Screencasts Page</h2>' }
]
pages.each do |p|
  page = Page.find_by(slug: p.slug)
  if page.nil?
    Page.create(p)
  end
end
