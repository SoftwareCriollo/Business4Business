class Picture < ActiveRecord::Base
  belongs_to :company
  belongs_to :project

  mount_uploader :file, ImageUploader

  scope :default_pic, -> { where(default: true) }
end
