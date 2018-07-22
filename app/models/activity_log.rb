class ActivityLog < ApplicationRecord
  belongs_to :baby
  belongs_to :assistant
  belongs_to :activity

  def duration
    (stop_time - start_time)/60
  end

end
