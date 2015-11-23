class User < ActiveRecord::Base
  rolify
  default_scope -> { order('created_at DESC') }
  include Authority::UserAbilities
  include Tokenable
  has_many :likes
  has_many :boards
  has_many :comments, dependent: :destroy

  has_attached_file :avatar,
    :path => ":rails_root/public/avatar/:id/:filename",
    :url  => "/avatar/:id/:filename",
    :default_url => "bootstrap/testimonials/user.jpg"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :uid, presence: true, uniqueness: { case_sensitive: false }
  validates :realname ,presence: true
  validates :phone ,presence: true, length: { is: 11 }

  # paperclip validations
  validates_attachment_content_type :avatar, :content_type => /^image\/(jpeg|jpg|png|gif)$/
  validates_attachment_size :avatar, :in => 0..10.megabytes

  after_create :set_default_role

  def like?(board)
    likes.find_by(board: board).present?
  end
 
  def like!(board)
    likes.create!(board: board)
  end
 
  def unlike!(board)
    likes.find_by(board: board).destroy
  end

  def share?(board)
    likes.find_by(board: board).present?
  end
 
  def share!(board)
    shares.create!(board: board)
  end

  private
  
  def set_default_role
    add_role :user
  end
end
