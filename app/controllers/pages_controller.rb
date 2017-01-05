class PagesController < ApplicationController
  def about
    @page = Page.find_by!(slug: 'about')
  end
  
  def contacts
    @page = Page.find_by!(slug: 'contacts')
  end
  
  def home
    @page = Page.find_by!(slug: 'home')
  end
end