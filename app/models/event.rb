class Event < ActiveRecord::Base
  has_many :votes
  
  validates :organiser_email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :organiser_email, :link1, :date1, :presence =>true
end
