FactoryBot.define do
  factory :frame, class: 'Frame' do
    transient do
      roll1 { association :roll, :not_strike }
      roll2 { association :roll, :not_spare, first_roll_pins: roll1.pins }
    end

    previous_frame { nil }
    rolls { [roll1, roll2] }
    initialize_with { new(previous_frame, rolls) }

    trait :strike do
      transient do
        roll1 { association :roll, :strike }
        roll2 { association :roll, :not_strike }
        roll3 { association :roll, :not_spare, first_roll_pins: roll2.pins }
      end
      rolls { [roll1, roll2, roll3] }
    end

    trait :spare do
      transient do
        roll1 { association :roll, :not_strike }
        roll2 { association :roll, :spare, first_roll_pins: roll1.pins }
        roll3 { association :roll }
      end
      rolls { [roll1, roll2, roll3] }
    end
  end
end
