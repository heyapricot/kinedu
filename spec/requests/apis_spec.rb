require 'rails_helper'

RSpec.describe "Apis", type: :request do
  describe "GET /api/activities" do
    activity_number = 4
    let!(:activities){FactoryBot.create_list(:activity,activity_number)}
    before {get api_activities_path}

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end

    it "returns a list of activities with id, name and description" do
      expect(json).not_to be_empty
      expect(json.size).to eq(activity_number)
    end
  end

  describe "GET /api/babies" do
    it "returns status code 200" do
      get api_babies_path
      expect(response).to have_http_status(200)
    end

    xit "returns a list of babies with name, age in months, parents name and contact info" do

    end
  end

  describe "GET /api/babies/:id/activity_logs" do

    let(:baby){FactoryBot.create(:baby)}

    it "returns status code 200" do
      get api_baby_activity_logs_path(baby.id)
      expect(response).to have_http_status(200)
    end

    xit "returns a list of activity_logs with id, baby_id, assistant_id, start_date, stop_date, terminated?" do

    end

  end

  describe "POST /api/activity_logs" do

    context "when the request is valid" do

      before { post api_activity_logs_path }

      xit "creates an activity log" do

      end

      pending "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do
      pending "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      pending "returns a validation failure message" do
        expect(response.body).to match(/Validation failed: Created by can't be blank/)
      end
    end

  end

  describe "PUT api/activity_logs/:id" do
    context "when the record exists" do

      before { put api_activity_log_path }

      xit "updates the record" do

      end

      pending "returns status code 204" do
        expect(response).to have_http_status(204)
      end
    end
  end
end
