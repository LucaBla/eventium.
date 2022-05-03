class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :hosted_events, class_name: "Event", foreign_key: "host_id"
  has_many :event_joinings, foreign_key: "joined_user_id"
  has_many :attended_events, through: :event_joinings, source: :event
  has_many :sended_invites, class_name: "Invitation", foreign_key: "inviter_id"
  has_many :received_invites, class_name: "Invitation", foreign_key: "invited_user_id"

  validates :username, uniqueness: true
  validates :username, presence: true
end
