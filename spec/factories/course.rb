FactoryBot.define do
  factory :course do
    author      { create :author }
    name        { FFaker::Lorem.sentence }
    description { FFaker::Lorem.paragraphs }
  end
end
