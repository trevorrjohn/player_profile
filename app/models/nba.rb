class NBA < Player
  include Initialer

  def name_brief
    [first_name, last_initial].compact.join ' '
  end
end
