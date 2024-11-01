FactoryBot.define do
  factory :address do
    postal_code { "MyString" }
    region_id { 1 }
    city { "MyString" }
    house_number { "MyString" }
    building_name { "MyString" }
    phone_number { "MyString" }
    order { nil }
  end
end
