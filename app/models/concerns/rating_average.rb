module RatingAverage
  extend ActiveSupport::Concern
  
  def average_rating
    total = 0.0
    ratings.each do |rating|
      total += rating.score
    end
    total / ratings.size
  end
  
end  