class Api::BabiesController < ApplicationController
  def index
    @babies = Baby.select(:id,:name,:mother_name,:father_name, :address, :phone)
    @babies = @babies.as_json
    Baby.all.each_with_index do |b,idx|
      @babies[idx]["age_in_months"] = b.age_in_months
    end
    json_response(@babies)
  end

end
