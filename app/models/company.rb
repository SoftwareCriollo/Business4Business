class Company < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :logo, LogoUploader
  delegate :name, to: :category,  prefix: 'category'

  validates :name, :type_company, presence: true, on: [ :create ]
  validates :website, presence: true, url: true, on: [ :update ]
  validates :name, :description, :category_id, :tax_id, :address, :type_company, :status, presence: true, on: [ :update ]

  belongs_to :category
  has_many :contacts,  dependent: :destroy
  has_many :payments,  dependent: :destroy
  has_many :projects,  dependent: :destroy
  has_and_belongs_to_many :skills

  accepts_nested_attributes_for :skills, :allow_destroy => true, :reject_if => :all_blank

  def approve_request_company
    update_attribute(:status, StatusCompany::APPROVE)
  end

  def reject_request_company
    update_attribute(:status, StatusCompany::REJECT)
  end

  def fee_paid?
    payment = payments.last
    payment.nil? ? false : !payment.time_expired?
  end

  def cancel_account
    update_attribute(:deleted_at, Time.current)
  end

  def active_for_authentication?
    super && !deleted_at
  end

end
