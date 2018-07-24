FactoryBot.define do
  factory :activity_log do
    start_time {DateTime.now}
    stop_time {DateTime.now + rand(1..24).hours}
    duration {(stop_time - start_time) * 60 unless stop_time.nil?}
    comments "MyString"
  end
end
