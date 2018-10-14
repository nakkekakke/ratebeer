class Style < ApplicationRecord
  include RatingAverage

  has_many :beers
  has_many :ratings, through: :beers

  def self.top(count)
    sorted_by_rating_in_desc_order = Style.all.sort_by{ |s| -(s.average_rating || 0) }

    if count >= Style.count
      sorted_by_rating_in_desc_order
    else
      sorted_by_rating_in_desc_order.take(count)
    end
  end
end
