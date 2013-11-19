class Role < ActiveRecord::Base
	has_one :user

	validates :role_name, presence: true, length: { maximum: 20 }
end
