require "csv"

task import_csv: :environment do
    csv_text = File.read(Rails.root.join("lib", "csvs", "movies.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
        @movie = Movie.find_by_name(row["Movie"])
        unless @movie
            m = Movie.new
            m.name = row["Movie"]
            m.description = row["Description"]
            m.year = row["Year"]
            m.director = row["Director"]
            m.filming_location = row["Filming location"]
            m.country = row["Country"]
            m.actors << Actor.find_or_create_by(:name => row["Actor"]) 
            m.save
        else
            begin
                @movie.actors << Actor.find_or_create_by(name: row["Actor"]) 
            rescue
                puts "duplicate record will be ignored"
            end
        end

    end
    puts "There are now #{Movie.count} rows in the Movies table and #{Actor.count} rows in the Actors table"


    csv_text = File.read(Rails.root.join("lib", "csvs", "reviews.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|

        @movie = Movie.find_by(name: row["Movie"])
        r = @movie.reviews.new
        r.user = row["User"]
        r.stars = row["Stars"]
        r.review = row["Review"]
        r.save!
    end
    puts "There are now #{Review.count} rows in the Reviews table"

end