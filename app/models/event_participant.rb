class EventParticipant < ApplicationRecord
  # validations
  

  #associations
  belongs_to :user
  belongs_to :event
end
