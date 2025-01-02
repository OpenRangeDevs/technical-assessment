FactoryBot.define do
  factory :admin do
    sequence(:name) { |n| "Admin #{n}" }
    sequence(:email) { |n| "admin#{n}@example.com" }
    phone { "123-456-#{rand(1000..9999)}" }
    role_level { rand(0..5) }
    active_status { true }
  end
end
