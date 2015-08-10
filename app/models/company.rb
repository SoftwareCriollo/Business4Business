class Company < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :logo, LogoUploader
  delegate :name, to: :category,  prefix: 'category'
  validates :name, :type_company, presence: true, on: [ :create ]
  validates :website, presence: true, url: true, on: [ :update ]

  validates :name, :description, :category_id, :tax_id, :address, :logo, :type_company, :status, presence: true, on: [ :update ]

  belongs_to :category
  has_many :contacts
  has_many :payments

  def fee_paid?
    payment = payments.last
    payment.nil? ? false : payment.date_valid?
  end

  def cancel_account
    update_attribute(:deleted_at, Time.current)
  end

  def active_for_authentication?
    super && !deleted_at
  end

end
