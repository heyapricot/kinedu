class Api::ActivitiesController < ApplicationController
  def index
    @activities = Activity.select(:id,:name,:description)
    json_response(@activities)
  end
end
