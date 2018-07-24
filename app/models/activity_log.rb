class ActivityLog < ApplicationRecord
  belongs_to :baby
  belongs_to :assistant
  belongs_to :activity

  scope :finished, ->{where("stop_time IS NOT NULL")}
  scope :in_progress, ->{where("stop_time IS NULL")}

  def status
    stop_time.nil? ? "En Progreso" : "Terminada"
  end

end
