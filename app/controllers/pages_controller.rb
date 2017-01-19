class PagesController < ApplicationController
  def about
    @page = Page.find_by!(slug: 'about')
  end
  
  def contacts
    @page = Page.find_by!(slug: 'contacts')
  end
  
  def guides
    @page = Page.find_by!(slug: 'guides')
  end
  
  def home
    @page = Page.find_by!(slug: 'home')
  end
  
  def open_source
    @page = Page.find_by!(slug: 'open-source')
  end
end
