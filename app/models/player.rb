class Player < ActiveRecord::Base
  def self.average_age_for_position(position)
    ages = where(position: position).pluck(:age)
    ages.reduce(:+) / ages.size if ages.present?
  end
end
