class Vote < ActiveRecord::Base
  belongs_to :event
  
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :email, presence: true
  
  before_create :assign_unique_token

  private

  def assign_unique_token
    self.unique_id = SecureRandom.hex(20)
  end

end
