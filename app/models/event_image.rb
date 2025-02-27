class EventImage < ApplicationRecord
  belongs_to :event
  mount_uploader :image, EventImageUploader

  validates :image, presence: true
end
