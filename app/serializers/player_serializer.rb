class PlayerSerializer < ActiveModel::Serializer
  cache
  attributes :id, :first_name, :last_name, :age, :position, :average_position_age_diff, :name_brief, :league,
    :team, :photo_url

  def id
    object.public_id
  end

  def average_position_age_diff
    age - average_age_for_position if age && average_age_for_position
  end

  def name_brief
    typed_object.name_brief
  end

  def league
    object.type
  end

  private

  def age
    object.age
  end

  def average_age_for_position
    @average_age_for_position ||= AverageAgeForPositionCacheManager.fetch typed_object.class, object.position
  end

  def typed_object
    @typed_object ||= object.becomes object.type.constantize
  end
end
