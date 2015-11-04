class User < ActiveRecord::Base
  include Tokenable
  has_attached_file :avatar,
  :path => ":rails_root/public/avatar/:id/:filename",
  :url  => "/avatar/:id/:filename"

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
end
