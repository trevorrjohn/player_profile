class NHL < Player
  def name_brief
    [first_name, last_name].compact.join ' '
  end
end
