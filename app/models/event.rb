class Event < ApplicationRecord
  belongs_to :host, class_name: "User"
  has_many :event_joinings, foreign_key: "attended_event_id", dependent: :destroy
  has_many :attendees, through: :event_joinings, source: :user, dependent: :destroy

  validates :title, :description, :event_date, presence: true

  scope :past, -> { where("event_date < ?", DateTime.now) }
  scope :future, -> { where("event_date > ?", DateTime.now) }
end
