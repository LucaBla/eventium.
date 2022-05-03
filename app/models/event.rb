class Event < ApplicationRecord
  belongs_to :host, class_name: "User"
  has_many :event_joinings, foreign_key: "attended_event_id"
  has_many :attendees, through: :event_joinings, source: :user
end
