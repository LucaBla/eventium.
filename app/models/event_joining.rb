class EventJoining < ApplicationRecord
  belongs_to :user, foreign_key: 'joined_user_id'
  belongs_to :event, foreign_key: 'attended_event_id'
end
