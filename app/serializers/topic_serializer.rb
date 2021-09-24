class TopicSerializer < ActiveModel::Serializer
  attributes :id, :name, :description

  attribute :liked

  def liked
    return true if current_user.topics.where(id: object.id).any?

    false
  end
end