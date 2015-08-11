class Rate < ActiveRecord::Base
  validates :amount, :type_company_id, numericality: true, presence: true
end