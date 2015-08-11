class Contact < ActiveRecord::Base
  belongs_to :company
  validates :first_name, :last_name, :email, :phone, presence: true
end
