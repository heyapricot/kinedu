class ActivityLog < ApplicationRecord
  belongs_to :baby
  belongs_to :assistant
  belongs_to :activity

  scope :finished, ->{where("stop_time IS NOT NULL")}
  scope :in_progress, ->{where("stop_time IS NULL")}

  before_update :set_duration

  def status
    stop_time.nil? ? "En Progreso" : "Terminada"
  end

  private

  def set_duration
    self.duration = (stop_time - start_time).minutes.to_i unless stop_time.nil?
  end

end
