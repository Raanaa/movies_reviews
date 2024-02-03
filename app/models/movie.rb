class Movie < ApplicationRecord
  has_many :movieactors
  has_many :actors, :through => :movieactors
  has_many :reviews

  def avg_stars
    self.reviews.pluck(:stars).sum / self.reviews.count # (sum of all stars / total num of reviews)
  end
end
