class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.get_ratings
    # @all_ratings will be ['G','PG','PG-13','R']

    @ratings = params[:ratings] ? params[:ratings].keys : nil
    # @ratings will be something like ["G", "PG-13"] or nil

    #raise params.inspect # shows the value of params
    #raise @ratings.inspect # shows the value of ratings

    @ratings_hash = Hash.new()
    @ratings.each { |r| @ratings_hash[r] = 1}
    # @ratings_hash will be something like {"G"=>1, "PG"=>1}

    @movies = Movie.where(rating: @ratings).order(params[:sort])
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
