class Vote < ActiveRecord::Base
  belongs_to :event

  validates_presence_of :email
end
