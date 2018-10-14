class Beer < ApplicationRecord
  include RatingAverage

  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user

  validates :name, presence: true
  validates :style, presence: true

  def to_s
    "#{name}, #{brewery.name}"
  end

  def average
    return 0 if ratings.empty?

    ratings.map(&:score).sum.to_f / ratings.count
  end

  def self.top(count)
    sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating || 0) }

    if count >= Beer.count
      sorted_by_rating_in_desc_order
    else
      sorted_by_rating_in_desc_order.take(count)
    end
  end
end
