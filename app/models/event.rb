class Event < ActiveRecord::Base
  has_many :votes

  validates_presence_of :link1
  validates_presence_of :date1
  validates_presence_of :organiser_email
end
