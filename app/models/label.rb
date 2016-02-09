class Label < ActiveRecord::Base
	has_many :boards, dependent: :nullify
end
