class Company < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :website, presence: true, url: true
  validates :name, :description, :category, :tax_id, :address, :logo, :type, presence: true

  belongs_to :category
  has_many :contacts
end
