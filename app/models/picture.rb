class Picture < ActiveRecord::Base
  belogns_to :company
  belogns_to :project

  mount_uploader :file, ImageUploader
end
