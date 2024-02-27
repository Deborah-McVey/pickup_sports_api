class User < ApplicationRecord
    has_secure_password
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
    
    after_create :create_profile 
    
    # events that the user has created
    has_many :created_events, class_name: 'Event', foreign_key: 'user_id'

    # events that the user is participating in
    has_many :event_participants
    has_many :events, through: :event_participants

    private
    def validate_user_name 
        unless user_name =~ /\A[a-zA-Z0-9_]+\Z/
            errors.add(:user_name, "can only contain letters, numbers, and underscores, and must contain at least one letter or number")
        end
    end    
end
