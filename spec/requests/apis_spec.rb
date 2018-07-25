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
      result = Baby.select(:id, :name, :mother_name, :father_name, :address, :phone)
      result = result.as_json
      Baby.all.each_with_index do |b,idx|
        result[idx]["age_in_months"] = b.age_in_months
      end
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
    let!(:activity_logs) do
      FactoryBot.create_list(:activity_log, activity_number, baby: baby, activity: activity, assistant: assistant)
    end

    before { get api_baby_activity_logs_path(baby.id)}

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end

    it "returns a list of activity_logs with id, baby_id, assistant_id, start_date, stop_date, terminated?" do
      result = baby.activity_logs.select(:id, :baby_id, :start_time).as_json
      baby.activity_logs.each_with_index do |al,idx|
        result[idx]["assistant"] = al.assistant.name
        result[idx]["stop_time"] = al.stop_time if al.status == "Terminada"
      end
      expect(json).not_to be_empty
      expect(json.size).to eq(activity_number)
      expect(json).to match_array(result)
    end

  end

  describe "POST /api/activity_logs" do

    let!(:baby){FactoryBot.create(:baby)}
    let!(:activity){FactoryBot.create(:activity)}
    let!(:assistant){FactoryBot.create(:assistant)}
    let(:attributes){{activity_id: activity.id, baby_id: baby.id, assistant_id: assistant.id, start_time: DateTime.now.to_s, stop_time: (DateTime.now + 1).to_s }}

    context "when the request is valid" do

      before { post api_activity_logs_path(attributes) }

      it "creates an activity log" do
        expect(json['activity_id']).to eq activity.id
        expect(ActivityLog.first.activity_id).to eq activity.id
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do
      before { post api_activity_logs_path }

      it "return status code 422" do
        expect(response).to have_http_status(422)
      end

    end
  end

  describe "PUT api/activity_logs/:id" do
    context "when the record exists" do

      time = DateTime.current
      comment = "Will this work?"

      let!(:baby){FactoryBot.create(:baby)}
      let!(:activity){FactoryBot.create(:activity)}
      let!(:assistant){FactoryBot.create(:assistant)}
      let!(:log){FactoryBot.create(:activity_log, baby: baby, activity: activity, assistant: assistant, start_time: DateTime.current - rand(1..23).hours, stop_time: nil )}
      let(:attributes){{stop_time: time, comments: comment }}

      before { put api_activity_log_path(log), params: attributes }

      it "updates the record" do
        al = ActivityLog.find(log.id)

        expect(response.body).to be_empty
        expect(al.stop_time.to_i).to eq time.to_i
        expect(al.comments).to eq comment
        expect(al.duration).to eq (al.stop_time - al.start_time).minutes
      end

      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
    end
  end
end
