require 'rails_helper'

RSpec.feature "ActivityLogActions", type: :feature do
  describe "GET /activity_logs" do
    activity_number = 3
    let!(:babies){FactoryBot.create_list(:baby, 2)}
    let!(:assistants){FactoryBot.create_list(:assistant, 2)}
    let!(:activity){FactoryBot.create(:activity)}
    let!(:logs) do
      FactoryBot.create_list(:activity_log, activity_number, baby: babies.first, assistant: assistants.first, activity: activity)
      FactoryBot.create_list(:activity_log, activity_number, baby: babies.first, assistant: assistants.second, activity: activity, stop_time: nil)
      FactoryBot.create_list(:activity_log, activity_number, baby: babies.second, assistant: assistants.first, activity: activity)
      FactoryBot.create_list(:activity_log, activity_number, baby: babies.second, assistant: assistants.second, activity: activity, stop_time: nil)
    end

    it "shows all activity logs" do
      visit activity_logs_path
      within_table "logs" do
        expect(page).to have_text(babies.first.name, count: activity_number * 2)
        expect(page).to have_text(babies.second.name, count: activity_number * 2)
        expect(page).to have_text(assistants.first.name, count: activity_number * 2)
        expect(page).to have_text(assistants.second.name, count: activity_number * 2)
      end
    end

    context "when a Baby is chosen from the filter" do
      it "only shows the records related to that baby" do
        visit activity_logs_path
        select babies.second.name, from: :baby_id
        click_button "Filtrar"
        within_table "logs" do
          expect(page).to have_text(babies.second.name, count: activity_number * 2)
          expect(page).to have_no_text(babies.first.name)
        end
      end
    end

    context "When an assistant is chosen from the dropdown" do
      it "only shows the records related to that assistant" do
        visit activity_logs_path
        select assistants.second.name, from: :assistant_id
        click_button "Filtrar"
        within_table "logs" do
          expect(page).to have_text(assistants.second.name, count: activity_number * 2)
          expect(page).to have_no_text(assistants.first.name)
        end
      end
    end

    context "When En progreso is chosen from the dropdown" do
      it "only shows activity logs that haven't been finished (No stop_time)" do
        visit activity_logs_path
        select "En Progreso", from: :status
        click_button "Filtrar"
        within_table "logs" do
          expect(page).to have_text(babies.first.name, count: activity_number)
          expect(page).to have_text(babies.second.name, count: activity_number)
        end
      end

    end

    context "When Terminada is chosen from the dropdown" do
      it "only shows activity logs that have finished (stop_time not null)" do
        visit activity_logs_path
        select "Terminada", from: :status
        click_button "Filtrar"
        within_table "logs" do
          expect(page).to have_text(babies.first.name, count: activity_number)
          expect(page).to have_text(babies.second.name, count: activity_number)
        end
      end
    end

    context "When a baby and a status are selected" do

      it "only shows records that match both of the selected filters" do
        visit activity_logs_path
        select babies.first.name, from: :baby_id
        select "En Progreso", from: :status
        click_button "Filtrar"
        within_table "logs" do
          expect(page).to have_text(babies.first.name, count: activity_number)
          expect(page).to have_text("En Progreso",count: activity_number)
          expect(page).to have_no_text(babies.second.name)
          expect(page).to have_no_text("Terminada")
        end
      end

    end

  end

end
