class Vote < ActiveRecord::Base
  belongs_to :event
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :email, presence: true


  (1..5).each do |x|
    create_method("link", x)
  end

  (1..3).each do |x|
    create_method("date", x)
  end

  def create_method(base, number)
    name = "#{base}#{number}sum"
    define_method(name) do
      attributes["#{name}"]
    end
  end
  
  def self.count_votes
    find_by_sql 'SELECT SUM("link1") AS link1sum, SUM("link2") AS link2sum,
     SUM("link3") AS link3sum, SUM("link4") AS link4sum, SUM("link5") AS link5sum,
     SUM("date1") As date1sum, SUM("date2") As date2sum, SUM("date3") AS date3sum'
  end
end
