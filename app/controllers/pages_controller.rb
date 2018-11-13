class PagesController < ApplicationController
  # GET /about
  def about
    @page = Page.find_by!(slug: 'about')
  end
  
  # GET /contacts
  def contacts
    @page = Page.find_by!(slug: 'contacts')
  end
  
  # GET /guides
  def guides
    @page = Page.find_by!(slug: 'guides')
  end
  
  # GET /
  def home
    @page = Page.find_by!(slug: 'home')
    @articles = Article.where(is_hidden: false).where.not(published_at: nil).order('position DESC').limit(3)
    @projects = Project.where(is_hidden: false).order('position DESC').limit(8)
    @testimonials = Testimonial.where(published: true).order('position DESC').limit(100)
    @employees = Employee.where(published: true).order('position DESC').limit(100)
  end
  
  # GET /open_source
  def open_source
    @page = Page.find_by!(slug: 'open-source')
  end
  
  # GET /services
  def services
    @page = Page.find_by!(slug: 'services')
  end
end
