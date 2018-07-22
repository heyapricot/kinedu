class Api::ActivitiesController < ApplicationController
  def index
    @activities = Activity.all.select(:id,:name,:description)
    json_response(@activities)
  end
end
