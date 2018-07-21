class Api::ActivityLogsController < ApplicationController
  def index
    id = params[:baby_id]
    id.nil? ? @logs = ActivityLog.all : @logs = Baby.find(id).activity_logs
    json_response(@logs)
  end

  def create

  end

  def update

  end
end
