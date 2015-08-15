class Project < ActiveRecord::Base
  has_and_belongs_to_many :skills, dependent: :destroy
  has_many :pictures, as: :owner, dependent: :destroy
  belongs_to :company

  mount_uploader :file, LogoUploader
  validates :name, :description, presence: true

  accepts_nested_attributes_for :pictures, allow_destroy: true, reject_if: lambda { |t| t['file'].blank? and t['id'].blank? }

  def timeframes
    read_attribute(:timeframes) ? read_attribute(:timeframes).strftime('%e %B, %Y') : read_attribute(:timeframes)
  end
end