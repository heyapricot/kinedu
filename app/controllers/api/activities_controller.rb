class Api::ActivitiesController < ApplicationController
  def index
    @activities = Activity.all
    json_response(@activities)
  end
end
