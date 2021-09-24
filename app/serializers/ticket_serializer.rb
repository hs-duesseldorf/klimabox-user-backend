class TicketSerializer < ActiveModel::Serializer
  attributes :id, :message, :user_id

  has_many :comments, serializer: CommentSerializer
end