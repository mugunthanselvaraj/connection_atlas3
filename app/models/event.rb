class Event < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  belongs_to :user
  has_one :event_location, dependent: :destroy
  accepts_nested_attributes_for :event_location, allow_destroy: true
end
