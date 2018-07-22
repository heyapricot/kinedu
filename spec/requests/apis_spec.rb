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
      result = Activity.select(:id, :name, :description).map{|a| a.as_json}
      expect(json).not_to be_empty
      expect(json.size).to eq(activity_number)
      expect(json).to match_array(result)
    end
  end

  describe "GET /api/babies" do
    baby_number = 4
    let!(:babies){FactoryBot.create_list(:baby,baby_number)}
    before{ get api_babies_path }

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end

    it "returns a list of babies with name, parents name and contact info" do
      result = Baby.select(:id, :name, :mother_name, :father_name, :address, :phone).map{|a| a.as_json}
      expect(json).not_to be_empty
      expect(json.size).to eq(baby_number)
      expect(json).to match_array(result)
    end
  end

  describe "GET /api/babies/:id/activity_logs" do
    activity_number = 4

    let!(:baby){FactoryBot.create(:baby)}
    let!(:activity){FactoryBot.create(:activity)}
    let!(:assistant){FactoryBot.create(:assistant)}
    let!(:activity_logs){FactoryBot.create_list(:activity_log, activity_number, baby: baby, activity: activity, assistant: assistant)}

    before { get api_baby_activity_logs_path(baby.id)}

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end

    it "returns a list of activity_logs with id, baby_id, assistant_id, start_date, stop_date, terminated?" do
      result = baby.activity_logs.select(:id, :start_time, :stop_time).map{|a| a.as_json}
      expect(json).not_to be_empty
      expect(json.size).to eq(activity_number)
      expect(json).to match_array(result)
    end

  end

  describe "POST /api/activity_logs" do

    let(:attributes){{activity_id: '10', baby_id: '1', assistant_id: '1', start_time: DateTime.now.to_s, stop_time: (DateTime.now + 1).to_s }}

    context "when the request is valid" do

      before { post api_activity_logs_path, params: attributes }

      it "creates an activity log" do
        expect(json['activity_id']).to eq 10
      end

      it "returns status code 201" do
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
