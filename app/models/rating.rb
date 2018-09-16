class Rating < ApplicationRecord
  belongs_to :beer

  def to_s
    beer.to_s << ": " << score.to_s
  end
end
