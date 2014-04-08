require 'net/http'

class Event < ActiveRecord::Base

  private
  has_many :votes
  
  validates :organiser_email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :organiser_email, :link1, :date1, :presence => true

  # Need to validate date1 seperately as it must be present
  validates :date1,
     date: { after: Proc.new { Time.now },
             before: Proc.new { Time.now + 1.year },
             message: 'must be after today and less than a year into the future' }

  # Need to validate date, date2 and date3 seperately as it must be present
  validates :date,
     date: { after: Proc.new { Time.now },  # Time.now is not a valid value
             before: Proc.new { Time.now + 1.year } ,
             message: 'must be after today and less than a year into the future' },
     :if => lambda { |o| o.date.present? }
             
  validates :date2,
     date: { after: Proc.new { Time.now },  # Time.now is not a valid value
             before: Proc.new { Time.now + 1.year } ,
             message: 'must be after today and less than a year into the future' },
     :if => lambda { |o| o.date2.present? }
             
  validates :date3,
     date: { after: Proc.new { Time.now },  # Time.now is not a valid value
             before: Proc.new { Time.now + 1.year } ,
             message: 'must be after today and less than a year into the future' },
     :if => lambda { |o| o.date3.present? }

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
    uri = URI(link)
    # Ensure the protocol is specified
    uri.scheme = "http" if !uri.scheme
    Net::HTTP.get(uri) =~ /<title>(.*?)<\/title>/
    $1 # get the first result from the matching
  end

  def get_page_title!(link)
    link = get_page_title(link)
  end

  def assign_unique_token
    self.unique_id = SecureRandom.urlsafe_base64(20)
  end
end
