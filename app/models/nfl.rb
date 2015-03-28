class NFL < Player
  def name_brief
    [first_initial, last_name].compact.join ' '
  end

  private

  def first_initial
    first_name[0] unless first_name.blank?
  end
end
