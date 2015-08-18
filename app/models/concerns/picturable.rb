module Picturable
  extend ActiveSupport::Concern
  included do
    has_many :pictures, as: :owner, dependent: :destroy
    accepts_nested_attributes_for :pictures, allow_destroy: true, reject_if: proc { |t| t['file'].blank? and t['id'].blank? }
  end
end