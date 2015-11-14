class Board < ActiveRecord::Base
  belongs_to :user
  belongs_to :board_type
  has_many :likes
  has_many :attachments, as: :attachable, dependent: :destroy
end
