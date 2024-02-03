class CreateMovieactors < ActiveRecord::Migration[7.0]
  def change
    create_table :movieactors do |t|
      t.timestamps
    end
    add_reference :movieactors, :movie, foreign_key: true
    add_reference :movieactors, :actor, foreign_key: true
    add_index :movieactors, [:movie_id, :actor_id], unique: true
  end
end
