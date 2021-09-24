class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :favorite_blogposts, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_and_belongs_to_many :topics, :through => :topics_users
  validates :email, uniqueness: {message: "E-Mail Adresse ist bereits vergeben"}, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Bitte gib eine gültige E-Mail-Adresse ein." }
  validates :password, length: { minimum: 8, message: "Passwort muss mindestens 8 Zeichen besitzen" }, if:  -> { crypted_password_changed? || new_record?}
  validates :password, confirmation: { message: "Passwörter stimmen nicht überein" }, if: -> { crypted_password_changed? || new_record?}
  validates :password_confirmation, presence: { message: "Darf nicht leer sein" } , if: -> { crypted_password_changed? || new_record?}
end
