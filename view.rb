class View

  def display_list(recipes)
    recipes.each_with_index do |recipe, index|
      done = recipe.done? ? '[X]' : '[ ]'
      puts "#{index + 1} - #{done} #{recipe.name}: #{recipe.description} (#{recipe.rating}/5) - Prep. Time: #{recipe.prep_time}"
    end
  end

  def ask_name
    puts "Enter recipe name:"
    gets.chomp
  end

  def ask_description
    puts "Enter recipe description"
    gets.chomp
  end

  def ask_rating
    puts "Enter rating (1-5):"
    gets.chomp.to_i
  end

  def ask_prep_time
    puts "Enter preparation time:"
    gets.chomp
  end

  def ask_index
    puts "Enter recipe index:"
    gets.chomp.to_i - 1
  end

  def ask_ingredient
    puts "Enter ingredient to search:"
    gets.chomp
  end
end
