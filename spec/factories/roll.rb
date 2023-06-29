FactoryBot.define do
  factory :roll, class: 'Roll' do
    attempt { (0..10).to_a.push(Roll::FOUL_INPUT).sample.to_s }
    initialize_with { new(attempt) }

    trait :second_roll do
      transient do
        first_roll_pins { (0..10).to_a.sample }
      end

      attempt do
        if first_roll_pins == 10
          (0..10).to_a.push(Roll::FOUL_INPUT).sample.to_s
        else
          (0..(10 - first_roll_pins)).to_a.push(Roll::FOUL_INPUT).sample.to_s
        end
      end
    end

    trait :not_strike do
      attempt { (0...10).to_a.push(Roll::FOUL_INPUT).sample.to_s }
    end

    trait :not_spare do
      transient do
        first_roll_pins { (0...10).to_a.sample }
      end
      attempt { (0...(10 - first_roll_pins)).to_a.push(Roll::FOUL_INPUT).sample.to_s }
    end

    trait :strike do
      attempt { '10' }
    end

    trait :spare do
      transient do
        first_roll_pins { (0..10).to_a.sample }
      end

      attempt { (10 - first_roll_pins).to_s }
    end
  end
end
