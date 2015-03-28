class MLB < Player
  include Initialer

  def name_brief
    [first_initial, last_initial].compact.join(' ')
  end
end
