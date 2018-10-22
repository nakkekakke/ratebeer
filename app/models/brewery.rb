class Brewery < ApplicationRecord
  include RatingAverage
  extend TopRated

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :year, numericality: {  only_integer: true,
                                    greater_than_or_equal_to: 1040,
                                    less_than_or_equal_to: ->(_) { Time.now.year } }

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil, false] }

end
