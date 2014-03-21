class Vote < ActiveRecord::Base
  belongs_to :event
  belongs_to :organiser

  validates_presence_of :email
end
