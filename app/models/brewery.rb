class Brewery < ApplicationRecord
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :year, numericality: {  only_integer: true,
                                    greater_than_or_equal_to: 1040,
                                    less_than_or_equal_to: ->(_) { Time.now.year } }

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil, false] }

  def self.top(count)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating || 0) }

    if count >= Brewery.count
      sorted_by_rating_in_desc_order
    else
      sorted_by_rating_in_desc_order.take(count)
    end
  end
end
