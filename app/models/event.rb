class Event < ActiveRecord::Base
  has_many :votes
  
  validates :organiser_email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :organiser_email, :link1, :date1, :presence =>true
  before_create :assign_unique_token

  private

  def assign_unique_token
    self.unique_id = SecureRandom.hex(20)
  end
end
