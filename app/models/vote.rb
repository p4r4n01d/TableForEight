class Vote < ActiveRecord::Base
  belongs_to :event

  validates_presence_of :email

  def create_method(base, number)
    name = "#{base}#{number}sum"
    define_method(name) do
      attributes["#{name}"]
    end
  end

  (1..5).each do |x|
    create_method("link", x)
  end

  (1..3).each do |x|
    create_method("date", x)
  end

  def self.count_votes
    find_by_sql 'SELECT SUM("link1") AS link1sum, SUM("link2") AS link2sum,
     SUM("link3") AS link3sum, SUM("link4") AS link4sum, SUM("link5") AS link5sum,
     SUM("date1") As date1sum, SUM("date2") As date2sum, SUM("date3") AS date3sum'
  end
end
