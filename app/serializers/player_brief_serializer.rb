class PlayerBriefSerializer < ActiveModel::Serializer
  cache
  attributes :id, :first_name, :last_name, :league, :team, :photo_url

  def id
    object.public_id
  end

  def league
    object.type
  end
end
