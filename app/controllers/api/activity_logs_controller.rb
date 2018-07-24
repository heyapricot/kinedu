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
    @activity_log = ActivityLog.find(params[:id])
    @activity_log.update!(activity_log_params)
    head :no_content
  end

  def activity_log_params
    params.permit(:activity_id, :baby_id, :assistant_id, :start_time, :stop_time, :comments)
  end
end
