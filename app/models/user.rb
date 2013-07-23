# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  email      :string(255)
#  username   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base

	has_secure_password

	def full_name
		first_name + " " + last_name
	end

	validates :first_name, presence: true, length: { maximum: 50 }
	validates :last_name, presence: true, length: { maximum: 50 }
	validates :username, presence: true, length: { maximum: 50 }
	validate :email, :email_format

	validates_length_of :password, :minimum => 6, :maximum => 100, :allow_blank => true

	private

		EMAIL_REGEX = /\A[\w+\-.]+@[a-z\s\-.]+\.[a-z]+\z/i.freeze
		def email_format
			if ( EMAIL_REGEX =~ email ) != 0
				errors.add(:email, "format is invalid" )
			end
		end

end
