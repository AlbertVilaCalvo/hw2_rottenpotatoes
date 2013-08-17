class Movie < ActiveRecord::Base
  
  def Movie.get_ratings # class method
    return self.select(:rating).map(&:rating).uniq # retrieve the ratings from database
  end

end
