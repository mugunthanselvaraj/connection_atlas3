class Event < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_time_must_be_before_end_time

  belongs_to :user
  has_one :event_location, dependent: :destroy
  accepts_nested_attributes_for :event_location, allow_destroy: true

  scope :active, -> { where("start_time <= ? and end_time >= ?", DateTime.now, DateTime.now) }
  scope :past, -> { where("start_time < ? and end_time < ?", DateTime.now, DateTime.now) }
  scope :upcoming, -> { where("start_time > ?", DateTime.now) }

  private

  def start_time_must_be_before_end_time
    if start_time.present? && end_time.present? && start_time > end_time
      errors.add(:start_time, "must be less than or equal to end time")
    end
  end
end
