FactoryBot.define do
  factory :author do
    first_name { FFaker::NameMX.first_name }
    last_name  { FFaker::NameMX.last_name }
  end
end
