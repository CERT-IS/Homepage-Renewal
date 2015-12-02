class Board < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }
  resourcify
  include Authority::Abilities
  self.authorizer_name = 'BoardAuthorizer'

  belongs_to :user
  belongs_to :board_type
  has_many :likes, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true
end
