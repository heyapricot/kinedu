class ActivityLogsController < ActionController::Base
  def index
    query = Hash.new
    query[:baby_id] = params[:baby_id] unless params[:baby_id].blank?
    query[:assistant_id] = params[:assistant_id] unless params[:assistant_id].blank?

    query.empty? ? @activity_logs = ActivityLog.all : @activity_logs = ActivityLog.where(query)
    @activity_logs = @activity_logs.finished if params[:status] == "Terminada"
    @activity_logs = @activity_logs.in_progress if params[:status] == "En Progreso"

  end
end
