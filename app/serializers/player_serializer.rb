class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :age, :position

  def id
    object.public_id
  end
end
