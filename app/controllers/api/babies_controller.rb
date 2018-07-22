class Api::BabiesController < ApplicationController
  def index
    @babies = Baby.select(:id,:name,:mother_name,:father_name, :address, :phone)
    json_response(@babies)
  end
end
