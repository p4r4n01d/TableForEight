require 'open-uri' # Part of ruby no need for gem
require 'nokogiri'

class Event < ActiveRecord::Base

  private
  has_many :votes
  
  validates :organiser_email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :organiser_email, :link1, :date1, :presence =>true
  before_create :assign_unique_token, :setLinks

  def setLinks
    if self.link1.present?
      self.name1 = get_page_title!(self.link1)
    end
    
    if self.link2.present?
      self.name2 = get_page_title!(self.link2)
    end

    if self.link3.present?
      self.name3 = get_page_title!(self.link3)
    end

    if self.link4.present?
      self.name4 = get_page_title!(self.link4)
    end

    if self.link5.present?
      self.name5 = get_page_title!(self.link5)
    end
  end

  # Given a URL, extract the page title
  def get_page_title(link)
    begin
      html = Nokogiri::HTML(open(link).read)
    rescue Exception => e
      puts "Couldn't read \"#{ link }\": #{ e }"
      exit
    end
    # Search for the title tag (xpath selector)
    html.xpath('/html/head/title[1]')[0].inner_text()
  end

  def get_page_title!(link)
    link = get_page_title(link)
  end

    def assign_unique_token
      self.unique_id = SecureRandom.urlsafe_base64(20)
    end
end
