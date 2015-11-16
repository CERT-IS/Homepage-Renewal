class Board < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }
  belongs_to :user
  belongs_to :board_type
  has_many :likes
  has_many :attachments, as: :attachable, dependent: :destroy

  validates :title ,presence: true
  validates :contents ,presence: true
end
