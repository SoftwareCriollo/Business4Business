class Project < ActiveRecord::Base
  has_and_belongs_to_many :skills
  mount_uploader :logo, LogoUploader

  validates :name, :description, presence: true
end