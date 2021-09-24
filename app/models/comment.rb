class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :ticket

  validates :message, presence: { message: "Darf nicht leer sein"}
end