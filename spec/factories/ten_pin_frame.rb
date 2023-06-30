require 'bowling_scorer/roll'
require 'bowling_scorer/frame'
require 'bowling_scorer/ten_pin/ten_pin_roll'
require 'bowling_scorer/ten_pin/ten_pin_frame'

FactoryBot.define do
  factory :ten_pin_frame, class: 'TenPinFrame' do
    transient do
      roll1 { association :ten_pin_roll, :not_strike }
      roll2 { association :ten_pin_roll, :not_spare, first_roll_pins: roll1.pins }
    end

    previous_frame { nil }
    rolls { [roll1, roll2] }
    initialize_with { new(previous_frame, rolls) }

    trait :strike do
      transient do
        roll1 { association :ten_pin_roll, :strike }
        roll2 { association :ten_pin_roll, :not_strike }
        roll3 { association :ten_pin_roll, :not_spare, first_roll_pins: roll2.pins }
      end
      rolls { [roll1, roll2, roll3] }
    end

    trait :spare do
      transient do
        roll1 { association :ten_pin_roll, :not_strike }
        roll2 { association :ten_pin_roll, :spare, first_roll_pins: roll1.pins }
        roll3 { association :ten_pin_roll }
      end
      rolls { [roll1, roll2, roll3] }
    end
  end
end
