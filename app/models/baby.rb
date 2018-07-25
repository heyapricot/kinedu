class Baby < ApplicationRecord
  has_many :activity_logs

  def age_in_months
    (Date.current.year * 12 + Date.current.month) - (birthday.year * 12 + birthday.month)
  end

end
