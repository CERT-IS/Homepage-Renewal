class User < ActiveRecord::Base
  include Tokenable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :uid, presence: true, uniqueness: { case_sensitive: false }
  validates :realname ,presence: true
  validates :phone ,presence: true, length: { is: 11 }
end
