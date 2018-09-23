class Brewery < ApplicationRecord
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, uniqueness: true, presence: true
  validates :year, numericality: {  only_integer: true,
                                    greater_than_or_equal_to: 1040,
                                    less_than_or_equal_to: 2018 }

  def print_report
    puts name
    puts "Established at year #{year}"
    puts "Number of beers #{beers.count}"
  end

  def restart
    self.year = 2018
    puts "changed year to #{year}"
  end
end
