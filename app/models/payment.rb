class Payment < ActiveRecord::Base
  belongs_to :company

  def date_valid?
    created_at >= (Time.now - 1.year)
  end
end
