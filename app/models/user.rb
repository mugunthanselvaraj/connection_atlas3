class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :date_of_birth, presence: true
  validates :gender, presence: true
  validate :must_be_at_least_16_years_old

  enum :gender, { not_specified: 0, male: 1, female: 2, other: 3 }
  has_many :events

  scope :active, -> { where(active: true) }

  mount_uploader :profile_picture, ProfilePictureUploader

  # Check if user is an admin
  def admin?
    self.admin
  end

  def deactivate!
    update(active: false)
  end

  private

  def must_be_at_least_16_years_old
    if date_of_birth.present? && date_of_birth > 16.years.ago.to_date
      errors.add(:date_of_birth, "must be at least 16 years old")
    end
  end
end
