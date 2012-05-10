class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :node
  attr_accessible :comment_text.string
end
