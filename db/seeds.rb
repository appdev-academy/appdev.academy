# Create static pages
about_page = Page.find_by(slug: 'about')
if about_page.nil?
  Page.create(
    slug: 'about',
    content: '# About Page',
    html_content: '<h1>About Page</h1> '
  )
end
contacts_page = Page.find_by(slug: 'contacts')
if contacts_page.nil?
  Page.create(
    slug: 'contacts',
    content: '# Contacts Page',
    html_content: '<h1>Contacts Page</h1> '
  )
end
home_page = Page.find_by(slug: 'home')
if home_page.nil?
  Page.create(
    slug: 'home',
    content: '# Home Page',
    html_content: '<h1>Home Page</h1> '
  )
end
portfolio_page = Page.find_by(slug: 'portfolio')
if portfolio_page.nil?
  Page.create(
    slug: 'portfolio',
    content: '# Portfolio Page',
    html_content: '<h1>Portfolio Page</h1>'
  )
end