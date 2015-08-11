class Project < ActiveRecord::Base
  has_and_belongs_to_many :skills, dependent: :destroy
  belongs_to :company

  mount_uploader :file, LogoUploader

  validates :name, :description, presence: true

  def timeframes
    read_attribute(:timeframes).strftime('%e %B, %Y')
  end
end