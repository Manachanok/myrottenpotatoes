# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController
    skip_before_action :authenticate!, only: [:show, :index, :search_tmdb]
    
    def index
        @movies = Movie.order(:title)
    end
  
    def show
        id = params[:id]
        @movie = Movie.find(id)
    end
    
    def new
        @movie = Movie.new
        # default: render 'new' template
    end
    
    def create
        @movie = Movie.create!(allow_params)
        flash[:notice] = "#{@movie.title} was successfully created."
        redirect_to movie_path(@movie)
    end
    
    def edit
        @movie = Movie.find params[:id]
    end

    def update
        @movie = Movie.find params[:id]
        @movie.update_attributes!(allow_params)
        flash[:notice] = "#{@movie.title} was successfully updated."
        redirect_to movie_path(@movie)
    end
    
    def destroy
        @movie = Movie.find(params[:id])
        @movie.destroy
        flash[:notice] = "Movie '#{@movie.title}' deleted."
        redirect_to movies_path
    end
    
    def allow_params
        params.require(:movie).permit(:title, :rating, :description, :release_date)
    end
    
    
    def search_tmdb
        require 'themoviedb'
        Tmdb::Api.key("b993d796a4ce23fd981ce8c1b2b5ef45")
        
        @search = Tmdb::Search.new
        @search.resource('person') # determines type of resource
        @search.query('#{params[:search_terms]}') # the query to search against
        @search.fetch # makes request
        
        # hardwire to simulate failure
        unless @search
            flash[:warning] = "'#{params[:search_terms]}' was not found in TMDb."
            redirect_to movies_path
        end
    end

end