class MLB < Player
  def name_brief
    [first_inital, last_initial].compact.join(' ')
  end

  private

  def first_inital
    first_name[0] unless first_name.blank?
  end

  def last_initial
    last_name[0] unless last_name.blank?
  end
end
