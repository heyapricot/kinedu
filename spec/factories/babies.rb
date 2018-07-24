FactoryBot.define do
  factory :baby do
    name {Faker::Pokemon.unique.name}
    birthday {Date.current - 2.years - rand(0..365)}
    mother_name {Faker::Pokemon.name}
    father_name {Faker::Pokemon.name}
    address {Faker::Address.full_address}
    phone {Faker::PhoneNumber.phone_number}
  end
end
