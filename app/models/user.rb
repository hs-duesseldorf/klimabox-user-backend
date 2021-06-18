class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :favorite_blogposts, dependent: :destroy
  validates :email, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Bitte gib eine gültige E-Mail-Adresse ein." }
  validates :password, length: { minimum: 8 }, if:  -> { crypted_password_changed? || new_record?}
  validates :password, confirmation: true, if: -> { crypted_password_changed? || new_record?}
  validates :password_confirmation, presence: true, if: -> { crypted_password_changed? || new_record?}
end
