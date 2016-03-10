class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	validates :first_name, presence: true, length: { maximum: 50 }
	validates :last_name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, 
					  uniqueness: { case_sensitive: false }

	has_secure_password

	validates :password, length: { minimum: 6 }
	validates :mobile_number, length: { minimum: 10, maximum: 10}
	geocoded_by :location
	after_validation :geocode
	has_attached_file :image, styles: { medium: "750x550#", small: "100x100#" }
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
