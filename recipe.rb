class Recipe
  attr_reader :name, :description, :rating, :prep_time

  def initialize(name, description, rating, prep_time)
    @name = name
    @description = description
    @rating = rating
    @done = false
    @prep_time = prep_time
  end

  def done?
    @done
  end

  def done!
    @done = true
  end
end

# macarronada = Recipe.new('macarronada', 'Macarrão e molho', 3)
# macarronada.name
# macarronada.description
# macarronada.rating
