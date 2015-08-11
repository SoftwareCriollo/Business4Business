class Skill < ActiveRecord::Base
  has_and_belongs_to_many :companies, dependent: :destroy
  has_and_belongs_to_many :projects, dependent: :destroy

  validates :name, presence: true
end