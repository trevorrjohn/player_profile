class NBA < Player
  def name_brief
    [first_name, last_initial].compact.join ' '
  end

  private

  def last_initial
    last_name[0] unless last_name.blank?
  end
end
