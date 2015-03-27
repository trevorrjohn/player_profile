FactoryGirl.define do
  factory :player do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    position { %W{C W RW SF G D QB WR TE S CB DB T DE DL}.sample }
    age { (18..40).to_a.sample }
    public_id { SecureRandom.uuid }
    type { %w{NHL NBA MLB NFL}.sample }

    trait :nhl do
      type 'NHL'
    end
    trait :nba do
      type 'NBA'
    end
    trait :mlb do
      type 'MLB'
    end
    trait :nfl do
      type 'NFL'
    end
  end

end
