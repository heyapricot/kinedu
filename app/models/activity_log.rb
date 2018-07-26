class ActivityLog < ApplicationRecord
  belongs_to :baby
  belongs_to :assistant
  belongs_to :activity

  validate :start_must_be_before_end_time

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

  private

  def start_must_be_before_end_time
    errors.add(:start_time, "must be before stop time") if !stop_time.nil? && start_time > stop_time
  end

end
