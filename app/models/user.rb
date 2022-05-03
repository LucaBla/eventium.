class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :hosted_events, class_name: "Event", foreign_key: "host_id"
  has_many :event_joinings, foreign_key: "joined_user_id"
  has_many :attended_events, through: :event_joinings, source: :event
end
