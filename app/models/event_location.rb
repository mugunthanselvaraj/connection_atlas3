class EventLocation < ApplicationRecord
  belongs_to :event
  validates :laltitude, presence: true
  validates :longitude, presence: true
end
