class Company < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  include Picturable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :logo, LogoUploader
  delegate :name, to: :category,  prefix: 'category'

  validates :name, :type, presence: true
  validates :website, presence: true, url: true, on: [ :update ]
  validates :description, :category_id, :tax_id, :address, :status, presence: true, on: [ :update ]

  belongs_to :category
  has_many :contacts,  dependent: :destroy
  has_many :payments,  dependent: :destroy
  has_many :projects,  dependent: :destroy
  has_and_belongs_to_many :skills, dependent: :destroy

  accepts_nested_attributes_for :skills, allow_destroy: true, reject_if: :all_blank

  scope :approved, -> { where(status: StatusCompany::APPROVE) }
  scope :profile_complete, -> { where(complete_profile: true) }

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

  def active?
    deleted_at
  end

  def dashboard_path
    company_dashboard_path
  end

  def constitution_date
    read_attribute(:constitution_date) ? read_attribute(:constitution_date).strftime('%e %B, %Y') : read_attribute(:constitution_date)
  end

  def after_sign_in_path
    company_can_access_dashboard? ? dashboard_path : path_to_redirect
  end

  def company_can_access_dashboard?
    complete_profile? and fee_paid? and status == StatusCompany::APPROVE
  end

  def path_to_redirect
    edit_company_path(self) unless complete_profile? and status == StatusCompany::APPROVE
    pay_path unless fee_paid?
  end
end
