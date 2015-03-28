class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :age, :position, :average_position_age_diff

  def id
    object.public_id
  end

  def average_position_age_diff
    age - average_age_for_position if age && average_age_for_position
  end

  private

  def age
    object.age
  end

  def average_age_for_position
    @average_age_for_position ||= object.type.constantize.average_age_for_position object.position
  end
end
