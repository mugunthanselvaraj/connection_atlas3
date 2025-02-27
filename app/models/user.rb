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
end
