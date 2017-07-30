class Player < ActiveRecord::Base
  belongs_to :heat

  validates :heat_id, presence: true
end
