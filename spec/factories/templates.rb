# frozen_string_literal: true
FactoryGirl.define do
  factory :template do
    sequence(:name) { Faker::Lorem.sentence }
    os 'debian'
    script Faker::Lorem.paragraph
    tag_list Array.new(3) { Faker::Lorem.word }.join(',')
    user
  end
end
