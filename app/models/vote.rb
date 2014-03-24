class Vote < ActiveRecord::Base
  belongs_to :event

  validates_presence_of :email

  def link1sum
    attributes['link1sum']
  end

  def link2sum
    attributes['link2sum']
  end

  def link3sum
    attributes['link3sum']
  end

  def link4sum
    attributes['link4sum']
  end

  def link5sum
    attributes['link5sum']
  end

  def date1sum
    attributes['date1sum']
  end

  def date2sum
    attributes['date2sum']
  end

  def date3sum
    attributes['date3sum']
  end

  def self.count_votes
    find_by_sql 'SELECT SUM("link1") AS link1sum, SUM("link2") AS link2sum,
     SUM("link3") AS link3sum, SUM("link4") AS link4sum, SUM("link5") AS link5sum,
     SUM("date1") As date1sum, SUM("date2") As date2sum, SUM("date3") AS date3sum'
  end
end
