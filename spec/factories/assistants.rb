FactoryBot.define do
  factory :assistant do
    name {Faker::DragonBall.character}
    group "MyString"
    address "MyString"
    phone "MyString"
  end
end
