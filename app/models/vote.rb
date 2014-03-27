class Vote < ActiveRecord::Base
  belongs_to :event
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :email, presence: true
  

  def self.get_votes_sum(event_id)
    Vote.find_by_sql("SELECT Count(link1) AS Counts, SUM(link1) AS link1sum, SUM(link2) AS link2sum,
     SUM(link3) AS link3sum, SUM(link4) AS link4sum, SUM(link5) AS link5sum,
     SUM(date1) As date1sum, SUM(date2) As date2sum, SUM(date3) AS date3sum FROM votes
     WHERE event_id="+event_id+"")
  end


end
