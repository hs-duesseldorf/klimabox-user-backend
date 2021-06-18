class FavoriteBlogpostSerializer < ActiveModel::Serializer
  attributes :user_id, :slug
end