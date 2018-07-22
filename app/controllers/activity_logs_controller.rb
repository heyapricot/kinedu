class ActivityLogsController < ActionController::Base
  def index
    @activity_logs = ActivityLog.all
  end
end
