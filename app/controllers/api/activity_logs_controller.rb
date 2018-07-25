class Api::ActivityLogsController < ApplicationController
  def index
    id = params[:baby_id]
    if id.nil?
      @logs = ActivityLog.all
    else
      baby = Baby.find(id)
      @logs = baby.activity_logs.select(:id, :baby_id).as_json
      baby.activity_logs.each_with_index do |al,idx|
        @logs[idx]["assistant"] = al.assistant.name
        @logs[idx]["start_time"] = al.start_time.iso8601
        @logs[idx]["stop_time"] = al.stop_time.iso8601 if al.status == "Terminada"
      end
    end
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
