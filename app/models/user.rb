class User < ApplicationRecord
    # validations
    validates :user_name, presence: true, uniqueness: true, length: {minimum: 3, maximum: 30}
    validate :validate_user_name
    validates :email, presence: true, uniqueness: true, length: {minimum: 5, maximum: 255}, format: {
        with: URI::MailTo::EMAIL_REGEXP
    }
    validates :first_name, presence: true
    validates :last_name, presence: true

    # associations
    has_many :posts, dependent: :destroy
    has_one :profile, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_one :location, as: :locationable, dependent: :destroy

    private
    def validate_user_name 
        unless user_name =~ /\A[a-zA-Z0-9_]+\Z/
            errors.add(:user_name, "can only contain letters, numbers, and underscores, and must contain at least one letter or number")
        end
    end    
end
