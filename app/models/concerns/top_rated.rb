module TopRated
  extend ActiveSupport::Concern

  def top_rated(count)
    sorted_by_rating_in_desc_order = all.sort_by{ |b| -(b.average_rating || 0) }
    sorted_by_rating_in_desc_order[0, count]
  end
end
