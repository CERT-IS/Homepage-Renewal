class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :board
  belongs_to :origin, foreign_key: "comment_id", class_name: "Comment"
  has_many	:replys, foreign_key: "comment_id", class_name: "Comment", dependent: :destroy
  
  validates :contents, presence: true
end
