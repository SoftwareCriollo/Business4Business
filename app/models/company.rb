class Company < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :website, presence: true, url: true, on: [ :update ]
  validates :name, :description, :category, :tax_id, :address, :logo, :type_company, presence: true, on: [ :update ]

  belongs_to :category
  has_many :contacts
end
