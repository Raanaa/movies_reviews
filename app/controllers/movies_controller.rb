class MoviesController < ApplicationController
    def index
        @movies = Movie.all

        if params[:search_by_actor] and params[:search_by_actor] != ""
            actor = Actor.where("name like ?", "%" + params[:search_by_actor] + "%").first
            @movies = actor.present? ? actor.movies : []
        end

        if params[:sort]
            movies_hash = Hash.new
            @movies.each { |m| 
            # sort by average stars
               p movies_hash[m] = m.avg_stars
            }
            @movies = movies_hash.sort_by { |movie, stars| stars }.to_h.keys if params[:sort] == "asd"
            @movies = movies_hash.sort_by { |movie, stars| -stars }.to_h.keys if params[:sort] == "des"

        end
    end
end
