# Create static pages
about_page = Page.find_by(slug: 'about')
if about_page.nil?
  Page.create(
    slug: 'about',
    content: '## About Page',
    html_content: '<h2>About Page</h2>'
  )
end
contacts_page = Page.find_by(slug: 'contacts')
if contacts_page.nil?
  Page.create(
    slug: 'contacts',
    content: '## Contacts Page',
    html_content: '<h2>Contacts Page</h2>'
  )
end
home_page = Page.find_by(slug: 'home')
if home_page.nil?
  Page.create(
    slug: 'home',
    content: '## Home Page',
    html_content: '<h2>Home Page</h2>'
  )
end
guides_page = Page.find_by(slug: 'guides')
if guides_page.nil?
  Page.create(
    slug: 'guides',
    content: '## Guides Page',
    html_content: '<h2>Guides Page</h2>'
  )
end
open_source_page = Page.find_by(slug: 'open_source')
if open_source_page.nil?
  Page.create(
    slug: 'open-source',
    content: '## Open Source Page',
    html_content: '<h2>Open Source Page</h2>'
  )
end
portfolio_page = Page.find_by(slug: 'portfolio')
if portfolio_page.nil?
  Page.create(
    slug: 'portfolio',
    content: '## Portfolio Page',
    html_content: '<h2>Portfolio Page</h2>'
  )
end
screencasts_page = Page.find_by(slug: 'screencasts')
if screencasts_page.nil?
  Page.create(
    slug: 'screencasts',
    content: '## Screencasts Page',
    html_content: '<h2>Screencasts Page</h2>'
  )
end