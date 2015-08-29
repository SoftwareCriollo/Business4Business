class Project < ActiveRecord::Base
  include Picturable
  has_and_belongs_to_many :skills, dependent: :destroy

  belongs_to :company

  mount_uploader :file, LogoUploader
  validates :name, :description, presence: true

  scope :availables, -> { joins(:company).where('companies.status = ? and companies.deleted_at is null', StatusCompany::APPROVE) }

  def timeframes
    read_attribute(:timeframes) ? read_attribute(:timeframes).strftime('%e %B, %Y') : read_attribute(:timeframes)
  end
end