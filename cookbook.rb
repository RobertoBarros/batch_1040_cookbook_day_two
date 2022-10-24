require 'csv'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_csv
  end

  def mark_as_done(recipe_index)
    recipe = @recipes[recipe_index]
    recipe.done!
    save_csv
  end

  private

  def load_csv
    recipes = []
    CSV.foreach(@csv_file_path) do |row|
      name = row[0]
      description = row[1]
      rating = row[2].to_i
      done = row[3] == 'true'
      prep_time = row[4]
      new_recipe = Recipe.new(name, description, rating, prep_time)
      new_recipe.done! if done
      recipes << new_recipe
    end
    recipes
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.done?, recipe.prep_time]
      end
    end
  end
end
