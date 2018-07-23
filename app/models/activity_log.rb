class ActivityLog < ApplicationRecord
  belongs_to :baby
  belongs_to :assistant
  belongs_to :activity

  def status
    stop_time.nil? ? "En Progreso" : "Terminada"
  end

end
