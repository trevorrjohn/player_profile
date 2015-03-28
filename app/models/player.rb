class Player < ActiveRecord::Base
  scope :with_age, -> { where 'age IS NOT NULL' }

  def self.average_age_for_position(position)
    ages = with_age.where(position: position).pluck(:age)
    ages.reduce(:+) / ages.size if ages.present?
  end
end
