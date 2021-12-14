class MoviesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def index
    movies = Movie.all
    render json: movies
  end

  def create
    movie = Movie.create(movie_params)
    render json: movie, status: :created
  end

  private

  def find_movie
    Movie.find(params[:id])
  end

  def movie_params
    params.permit(
      :title,
      :year,
      :length,
      :director,
      :description,
      :poster_url,
      :category,
      :discount,
      :female_director,
    )
  end

  def render_not_found
    render json: { error: 'movie not found' }, status: :not_found
  end

  def render_unprocessable_entity(invalid)
    render json: {
             errors: invalid.record.errors.full_messages,
           },
           status: :unprocessable_entity
  end
end
