require 'rails_helper'

RSpec.feature "ActivityLogActions", type: :feature do
  describe "GET /activity_logs" do
    activity_number = 3
    let!(:babies){FactoryBot.create_list(:baby, 2)}
    let!(:assistants){FactoryBot.create_list(:assistant, 2)}
    let!(:activity){FactoryBot.create(:activity)}
    let!(:logs){FactoryBot.create_list(:activity_log, activity_number, baby: babies.first, assistant: assistants.first, activity: activity)}

    it "shows all activity logs" do
      visit activity_logs_path
      within_table "logs" do
        expect(page).to have_text(babies.first.name, count: activity_number)
        expect(page).to have_text(assistants.first.name, count: activity_number)
      end
    end

    context "when a Baby is chosen from the filter" do
      activity_number = 3
      let!(:first_logs){FactoryBot.create_list(:activity_log, activity_number, baby: babies.first, assistant: assistants.first, activity: activity)}
      let!(:second_logs){FactoryBot.create_list(:activity_log, activity_number, baby: babies.second, assistant: assistants.first, activity: activity)}

      it "only shows the records related to that baby" do
        visit activity_logs_path
        select babies.second.name, from: :baby_id
        click_button "Filtrar"
        within_table "logs" do
          expect(page).to have_text(babies.second.name, count: activity_number)
          expect(page).to have_no_text(babies.first.name)
        end
      end
    end

    context "When an assistant is chosen from the dropdown" do
      let!(:first_logs){FactoryBot.create_list(:activity_log, activity_number, baby: babies.first, assistant: assistants.first, activity: activity)}
      let!(:second_logs){FactoryBot.create_list(:activity_log, activity_number, baby: babies.first, assistant: assistants.second, activity: activity)}

      it "only shows the records related to that baby" do
        visit activity_logs_path
        select assistants.second.name, from: :assistant_id
        click_button "Filtrar"
        within_table "logs" do
          expect(page).to have_text(assistants.second.name, count: activity_number)
          expect(page).to have_no_text(assistants.first.name)
        end
      end

    end
  end

end
