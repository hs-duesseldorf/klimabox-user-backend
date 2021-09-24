class CommentSerializer < ActiveModel::Serializer
  attributes :id, :message, :created_at

  attribute :user_email

  def user_email
    user = User.find_by(id: object.user_id)

    user.email
  end
end