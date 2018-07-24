FactoryBot.define do
  factory :activity do
    name {Faker::Esport.game}
    description "MyString"
  end
end
