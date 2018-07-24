class Api::ActivityLogsController < ApplicationController
  def index
    id = params[:baby_id]
    id.nil? ? @logs = ActivityLog.all : @logs = Baby.find(id).activity_logs.select(:id, :start_time, :stop_time)
    json_response(@logs)
  end

  def create
    @activity_log = ActivityLog.create!(activity_log_params)
    json_response(@activity_log, :created)
  end

  def update

  end

  def activity_log_params
    params.permit(:activity_id, :baby_id, :assistant_id, :start_time, :stop_time)
  end
end
