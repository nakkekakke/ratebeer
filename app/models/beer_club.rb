class BeerClub < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, source: :user

  validates :name, presence: true
  validates :founded, numericality: {   only_integer: true,
                                        greater_than_or_equal_to: 1000,
                                        less_than_or_equal_to: ->(_) { Time.now.year } }
  validates :city, presence: true
end
