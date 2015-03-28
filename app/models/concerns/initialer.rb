module Initialer
  def first_initial
    "#{first_name[0]}." unless first_name.blank?
  end

  def last_initial
    "#{last_name[0]}." unless last_name.blank?
  end
end
