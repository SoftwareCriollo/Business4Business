class Payment < ActiveRecord::Base
  belongs_to :company

  def time_expired?
    created_at <= (Time.now - 1.year)
  end
end
