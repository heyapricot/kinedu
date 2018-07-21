class Api::BabiesController < ApplicationController
  def index
    @babies = Baby.all
    json_response(@babies)
  end
end
