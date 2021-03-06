class Vote < ActiveRecord::Base
  belongs_to :event
  
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :email, presence: true

  def self.get_votes_count(event_id, db_column, count_value)
    Vote.find_by_sql("SELECT Count("+db_column+") AS Counts FROM votes
     WHERE event_id="+event_id+" AND "+db_column+"="+count_value.to_s+"")
  end

  def self.get_emails(event_id, db_column, count_value)
    Vote.select(:email)
      .where("event_id = "+ event_id +" AND "+db_column+" = "+ count_value.to_s+"")
      .order(:email)
  end

  def self.get_count_details(event_id)
  @count_details =  { :voting => { :link1 => {
       :going => {
        :count =>  get_votes_count(event_id, 'link1', 1),
        :emails => get_emails(event_id, 'link1', 1)
        },
       :notgoing => {
        :count =>  get_votes_count(event_id, 'link1', -1),
        :emails => get_emails(event_id, 'link1', -1)
       }
     },
     :link2 => {
       :going => {
        :count =>  get_votes_count(event_id, 'link2', 1),
        :emails => get_emails(event_id, 'link2', 1)
        },
       :notgoing => {
        :count =>  get_votes_count(event_id, 'link2', -1),
        :emails => get_emails(event_id, 'link2', -1)
       }
     },
     :link3 => {
       :going => {
        :count =>  get_votes_count(event_id, 'link3', 1),
        :emails => get_emails(event_id, 'link3', 1)
        },
       :notgoing => {
        :count =>  get_votes_count(event_id, 'link3', -1),
        :emails => get_emails(event_id, 'link3', -1)
       }
     },
     :link4 => {
       :going => {
        :count =>  get_votes_count(event_id, 'link4', 1),
        :emails => get_emails(event_id, 'link4', 1)
        },
       :notgoing => {
        :count =>  get_votes_count(event_id, 'link4', -1),
        :emails => get_emails(event_id, 'link4', -1)
       }
     },
     :link5 => {
       :going => {
        :count =>  get_votes_count(event_id, 'link5', 1),
        :emails => get_emails(event_id, 'link5', 1)
        },
       :notgoing => {
        :count =>  get_votes_count(event_id, 'link5', -1),
        :emails => get_emails(event_id, 'link5', -1)
       }
     },
     :date1 => {
       :going => {
        :count =>  get_votes_count(event_id, 'date1', 1),
        :emails => get_emails(event_id, 'date1', 1)
        },
       :notgoing => {
        :count =>  get_votes_count(event_id, 'date1', -1),
        :emails => get_emails(event_id, 'date1', -1)
       },
       :maybe => {
        :count =>  get_votes_count(event_id, 'date1', 0),
        :emails => get_emails(event_id, 'date1', 0)
       }
     },
     :date2 => {
       :going => {
        :count =>  get_votes_count(event_id, 'date2', 1),
        :emails => get_emails(event_id, 'date2', 1)
        },
       :notgoing => {
        :count =>  get_votes_count(event_id, 'date2', -1),
        :emails => get_emails(event_id, 'date2', -1)
       },
       :maybe => {
        :count =>  get_votes_count(event_id, 'date2', 0),
        :emails => get_emails(event_id, 'date2', 0)
       }
     },
     :date3 => {
       :going => {
        :count =>  get_votes_count(event_id, 'date3', 1),
        :emails => get_emails(event_id, 'date3', 1)
        },
       :notgoing => {
        :count =>  get_votes_count(event_id, 'date3', -1),
        :emails => get_emails(event_id, 'date3', -1)
       },
       :maybe => {
        :count =>  get_votes_count(event_id, 'date3', 0),
        :emails => get_emails(event_id, 'date3', 0)
       }
     }}}
  end

  private
  
  before_create :assign_unique_token

  def assign_unique_token
    self.unique_id = SecureRandom.urlsafe_base64(20)
  end

end
