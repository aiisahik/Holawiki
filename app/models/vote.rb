class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :nodes


  attr_accessible :node_id, :user_id, :vote
end
