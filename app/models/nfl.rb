class NFL < Player
  include Initialer

  def name_brief
    [first_initial, last_name].compact.join ' '
  end
end
