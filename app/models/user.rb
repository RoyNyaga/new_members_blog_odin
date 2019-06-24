class User < ApplicationRecord
  attr_accessor :remember_token

  has_many :microposts, dependent: :destroy

	before_save :downcase_email
	
	validates :name,  presence: true, length: { maximum: 50 }
  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    def downcase_email
      self.email.downcase
    end 

  class << self # another method for defining class methods.
      # Returns the hash digest of the given string.
      def digest(string) # Generally this was suppose to look like self.digest(string) but due to the "Class << self" above no need
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
      end

      # Returns a random token.
      def new_token
        SecureRandom.urlsafe_base64
      end
  end

    

    # Remembers a user in the database for use in persistent sessions.
    # or 
    # It updates the remember_digest in the database with a remember_token.
    def remember
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token)) # creates a digest of the remember me token before saving in the database
    end

    # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

    # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

end
